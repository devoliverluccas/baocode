import '../chat/chat_models.dart';
import '../workspace/companies.dart';
import '../workspace/workspace.dart';

/// What a character in the office is shown doing, from its conversation's
/// status and the tool it runs (see [activityOf]).
enum OfficeActivity {
  /// Waiting on the user: standing, waving, a "!" over it.
  waving,

  /// Reading or searching: at the bookshelf.
  reading,

  /// Editing, or at work on anything else: typing at its PC.
  typing,

  /// Running a command: at the server.
  server,

  /// On the web: at the window.
  window,

  /// Running a subagent: an intern comes in.
  intern,

  /// Finished, unseen: a ✅ bubble.
  done,

  /// Active but idle: coffee on the sofa.
  coffee,
}

OfficeActivity activityOf(ThreadStatus status, ToolKind? tool) =>
    switch (status) {
      ThreadStatus.needsInput => OfficeActivity.waving,
      ThreadStatus.running => switch (tool) {
        ToolKind.read ||
        ToolKind.grep ||
        ToolKind.listDir ||
        ToolKind.search => OfficeActivity.reading,
        ToolKind.command => OfficeActivity.server,
        ToolKind.web => OfficeActivity.window,
        ToolKind.agent => OfficeActivity.intern,
        _ => OfficeActivity.typing,
      },
      ThreadStatus.unread => OfficeActivity.done,
      ThreadStatus.idle => OfficeActivity.coffee,
    };

/// A conversation as the office reads it: plain, so tests need no app.
class OfficeThread {
  const OfficeThread({
    required this.project,
    required this.title,
    required this.status,
    this.active = false,
    this.tool,
    this.thread,
  });

  final Project project;
  final String title;

  /// As the sidebar shows it ([AgentThread.shownStatus]).
  final ThreadStatus status;
  final bool active;

  /// The tool its turn runs now, if any.
  final ToolKind? tool;

  /// The conversation, to open and act on; null only in tests.
  final AgentThread? thread;

  /// In the sidebar's Ativas: kept active, or something going on.
  bool get listedActive => active || status != ThreadStatus.idle;
}

/// A character: one conversation in the Ativas.
class OfficeAgent {
  OfficeAgent(this.source)
    : activity = activityOf(source.status, source.tool),
      sprite = _spriteOf(source.title);

  final OfficeThread source;
  final OfficeActivity activity;

  /// Which character sheet it wears, the same for the same title.
  final int sprite;

  AgentThread? get thread => source.thread;
  String get title => source.title;
  ThreadStatus get status => source.status;

  /// How many character sheets there are (assets/office/characters).
  static const sprites = 6;

  // Not String.hashCode: the same character from run to run.
  static int _spriteOf(String title) =>
      title.codeUnits.fold(0, (sum, unit) => (sum * 31 + unit) & 0xffff) %
      sprites;
}

/// A project with conversations in the Ativas.
class OfficeRoom {
  OfficeRoom(this.project, this.agents);

  /// At most this many characters show in a room; the rest are [overflow].
  static const maxVisible = 4;

  final Project project;

  /// Those waiting on the user first, then working, finished, idle.
  final List<OfficeAgent> agents;

  List<OfficeAgent> get visible => agents.take(maxVisible).toList();
  int get overflow => agents.length - visible.length;

  /// Someone in it waits on the user: its "❗" shows, overflow or not.
  bool get waiting =>
      agents.any((agent) => agent.status == ThreadStatus.needsInput);
}

/// A company's building: its rooms, and its other projects as dim squares.
class OfficeBuilding {
  OfficeBuilding({
    required this.name,
    required this.rooms,
    required this.dim,
    this.company,
  });

  /// Null for the projects in no company.
  final Company? company;
  final String name;
  final List<OfficeRoom> rooms;

  /// Its projects with nothing in the Ativas.
  final List<Project> dim;

  /// Its company's color, as ARGB; null: grey.
  int? get color => company?.color;
  String? get icon => company?.icon;
}

class OfficeCampus {
  OfficeCampus(this.buildings);

  final List<OfficeBuilding> buildings;

  Iterable<OfficeAgent> get agents => [
    for (final building in buildings)
      for (final room in building.rooms) ...room.agents,
  ];

  int _count(ThreadStatus status) =>
      agents.where((agent) => agent.status == status).length;

  /// The reception's counts.
  int get working => _count(ThreadStatus.running);
  int get waiting => _count(ThreadStatus.needsInput);
  int get done => _count(ThreadStatus.unread);
}

/// The campus: a building per company shown, in [companies]' order, then
/// one named [noCompany] for the projects in none. [projects] in the
/// sidebar's order (pinned first); [threads] those the sidebar lists, not
/// archived.
OfficeCampus buildCampus({
  required List<Company> companies,
  required Company? Function(Project project) companyOf,
  required List<Project> projects,
  required List<OfficeThread> threads,
  required String noCompany,
}) {
  final active = threads.where((thread) => thread.listedActive).toList();
  OfficeBuilding building(String name, List<Project> mine, Company? company) {
    final rooms = <OfficeRoom>[];
    final dim = <Project>[];
    for (final project in mine) {
      // By status, most urgent first; the input's order within one.
      final agents = [
        for (final status in ThreadStatus.values)
          for (final thread in active)
            if (thread.project == project && thread.status == status)
              OfficeAgent(thread),
      ];
      if (agents.isEmpty) {
        dim.add(project);
      } else {
        rooms.add(OfficeRoom(project, agents));
      }
    }
    return OfficeBuilding(name: name, rooms: rooms, dim: dim, company: company);
  }

  final none = [
    for (final project in projects)
      if (companyOf(project) == null) project,
  ];
  return OfficeCampus([
    for (final company in companies)
      if (!company.hidden)
        if ([
              for (final project in projects)
                if (companyOf(project)?.name == company.name) project,
            ]
            case final mine when mine.isNotEmpty)
          building(company.name, mine, company),
    if (none.isNotEmpty) building(noCompany, none, null),
  ]);
}

/// The campus of [workspace]'s sidebar, now.
OfficeCampus campusOf(
  Workspace workspace,
  Companies companies, {
  required String noCompany,
}) {
  final threads = [
    for (final thread in workspace.threads)
      if (!thread.archived &&
          !thread.untouched &&
          !workspace.isHidden(thread.project) &&
          workspace.listsHost(thread.project.host) &&
          workspace.listsInSidebar(thread))
        thread,
  ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return buildCampus(
    companies: companies.list,
    companyOf: (project) => companies.of(project.path),
    projects: workspace.sidebarProjectsHere,
    noCompany: noCompany,
    threads: [
      for (final thread in threads)
        OfficeThread(
          project: thread.project,
          title: thread.title,
          status: thread.shownStatus,
          active: thread.active,
          tool: runningTool(thread),
          thread: thread,
        ),
    ],
  );
}

/// The tool [thread]'s turn runs now: its last call still running, a
/// subagent's as [ToolKind.agent]. Not read from a session not open, which
/// would open it.
ToolKind? runningTool(AgentThread thread) {
  if (!thread.isOpen) return null;
  final session = thread.session;
  for (var i = session.itemCount - 1; i >= 0; i--) {
    switch (session.itemAt(i)) {
      case UserMessageItem():
        return null;
      case ToolCallItem(:final kind, status: ToolStatus.running):
        return kind;
      case AgentItem(status: CommandStatus.running):
        return ToolKind.agent;
      default:
    }
  }
  return null;
}
