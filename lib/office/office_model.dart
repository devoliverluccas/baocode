import '../chat/chat_models.dart';
import '../chat/widgets/tool_call_row.dart' show toolVerb;
import '../l10n/l10n.dart';
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

  /// Active but idle: sat at its desk, still.
  coffee,
}

/// The tool kind [current] runs, as [activityOf] reads it.
ToolKind? kindOf(ChatItem? current) => switch (current) {
  ToolCallItem(:final kind) => kind,
  AgentItem() => ToolKind.agent,
  _ => null,
};

/// The short line of a character's bubble, for its [status] and what its
/// turn runs now ([current], see [runningItem]); null: no bubble.
String? activityText(
  ThreadStatus status,
  ChatItem? current,
  AppLocalizations l10n, {
  int max = 28,
}) => switch (status) {
  ThreadStatus.needsInput => l10n.officeNeedsYou,
  ThreadStatus.unread => l10n.officeDoneOpen,
  ThreadStatus.idle => null,
  ThreadStatus.running => _clip(switch (current) {
    // The Workflow tool, a skill, anything else: by what it names. Their
    // labels are English, made by the translator.
    ToolCallItem(kind: ToolKind.other, :final label, :final target) =>
      switch (label) {
        'Workflow' => l10n.officeWorkflow(_base(target)),
        'Using skill' => l10n.officeUsing('skill $target'),
        _ => l10n.officeUsing(_base(target.isEmpty ? label ?? '' : target)),
      },
    ToolCallItem(:final kind, :final target, :final status) => [
      toolVerb(kind, status: status, l10n: l10n).toLowerCase(),
      if (target.isNotEmpty) _base(target),
    ].join(' '),
    AgentItem(:final description) => l10n.officeDelegating(description),
    _ => l10n.officeThinking,
  }, max),
};

/// A path's last part; anything else as it is.
String _base(String target) {
  final text = target.trim();
  if (text.contains(' ') || text.contains('://')) return text;
  return text
      .split(RegExp(r'[/\\]'))
      .lastWhere((part) => part.isNotEmpty, orElse: () => text);
}

String _clip(String text, int max) =>
    text.length <= max ? text : '${text.substring(0, max - 1)}…';

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
    this.current,
    this.thread,
  });

  final Project project;
  final String title;

  /// As the sidebar shows it ([AgentThread.shownStatus]).
  final ThreadStatus status;
  final bool active;

  /// What its turn runs now ([runningItem]): a [ToolCallItem], an
  /// [AgentItem] or the [LiveStatusItem] of one thinking; null if none.
  final ChatItem? current;

  /// The conversation, to open and act on; null only in tests.
  final AgentThread? thread;

  /// In the sidebar's Ativas: kept active, or something going on.
  bool get listedActive => active || status != ThreadStatus.idle;
}

/// A character: one conversation in the Ativas.
class OfficeAgent {
  OfficeAgent(this.source)
    : activity = activityOf(source.status, kindOf(source.current)),
      hash = hashOf(source.thread?.id ?? source.title);

  final OfficeThread source;
  final OfficeActivity activity;

  /// Its conversation's, from run to run: what it looks like, its desk.
  final int hash;

  /// As Pixel Agents' palettes and hue shifts: which character sheet it
  /// wears ([sprite]), then one of 8 turns of its colors ([hue], in
  /// degrees; none first). The same for the same conversation.
  int get sprite => hash % sprites;
  double get hue => hash ~/ sprites % 8 * 45.0;

  AgentThread? get thread => source.thread;
  String get title => source.title;
  ThreadStatus get status => source.status;

  /// How many character sheets there are (assets/office/characters).
  static const sprites = 6;

  // Not String.hashCode: the same from run to run.
  static int hashOf(String key) =>
      key.codeUnits.fold(0, (sum, unit) => (sum * 31 + unit) & 0xfffffff);
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
          current: runningItem(thread),
          thread: thread,
        ),
    ],
  );
}

/// What [thread]'s turn runs now: its last call still running, or the
/// subagent running; else, while it streams, its [LiveStatusItem]. Not read
/// from a session not open, which would open it.
ChatItem? runningItem(AgentThread thread) {
  if (!thread.isOpen) return null;
  final session = thread.session;
  LiveStatusItem? live;
  for (var i = session.itemCount - 1; i >= 0; i--) {
    switch (session.itemAt(i)) {
      case UserMessageItem():
        return live;
      case final ToolCallItem item when item.status == ToolStatus.running:
        return item;
      case final AgentItem item when item.status == CommandStatus.running:
        return item;
      case final LiveStatusItem item:
        live = item;
      default:
    }
  }
  return live;
}
