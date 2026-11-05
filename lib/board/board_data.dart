import '../workspace/companies.dart';
import '../workspace/workspace.dart';

/// The board's columns, as Vibe Kanban's statuses (see CREDITS.md): by
/// what a conversation needs from the user, then what it is kept as.
enum BoardColumn {
  /// Its turn runs ([ThreadStatus.running]).
  working,

  /// Waiting on an answer ([ThreadStatus.needsInput]).
  needsYou,

  /// Finished, not seen yet ([ThreadStatus.unread]).
  done,

  /// Kept active ([AgentThread.active]), nothing going on.
  active,

  /// The rest of the history: neither active nor going on. Folded at first.
  idle,

  /// Archived, whatever it does. Folded at first.
  archived;

  /// Dropped on, a conversation becomes what the column is; the first
  /// three go by what it does, which nothing dropped changes.
  bool get droppable => index >= active.index;

  /// Shown folded until opened.
  bool get folded => this == idle || this == archived;
}

/// The board's views (see [BoardPage]).
enum BoardView { kanban, cards, table }

/// A conversation as the board reads it: plain, so tests need no app.
class BoardThread {
  const BoardThread({
    required this.project,
    required this.title,
    required this.status,
    required this.updatedAt,
    this.company,
    this.active = false,
    this.archived = false,
    this.pinned = false,
    this.diff,
    this.kernel,
    this.thread,
  });

  /// [thread] as the board shows it, in [company].
  factory BoardThread.of(AgentThread thread, Company? company) => BoardThread(
    project: thread.project,
    title: thread.title,
    status: thread.shownStatus,
    updatedAt: thread.updatedAt,
    company: company,
    active: thread.active,
    archived: thread.archived,
    pinned: thread.pinned,
    diff: thread.diff,
    kernel: thread.kernel.id,
    thread: thread,
  );

  final Project project;
  final String title;

  /// As the sidebar shows it ([AgentThread.shownStatus]).
  final ThreadStatus status;
  final DateTime updatedAt;

  /// Its project's; null for none.
  final Company? company;
  final bool active;
  final bool archived;
  final bool pinned;
  final ({int added, int removed})? diff;

  /// Its kernel's id ([KernelDescriptor.id]): 'claude-code', 'codex'.
  final String? kernel;

  /// The conversation, to open and act on; null only in tests.
  final AgentThread? thread;

  BoardColumn get column =>
      columnOf(status, active: active, archived: archived);
}

/// The column of a conversation [status], kept [active] or [archived].
BoardColumn columnOf(
  ThreadStatus status, {
  bool active = false,
  bool archived = false,
}) {
  if (archived) return BoardColumn.archived;
  return switch (status) {
    ThreadStatus.running => BoardColumn.working,
    ThreadStatus.needsInput => BoardColumn.needsYou,
    ThreadStatus.unread => BoardColumn.done,
    ThreadStatus.idle => active ? BoardColumn.active : BoardColumn.idle,
  };
}

/// What the views do to conversations: the sidebar's own actions.
class BoardActions {
  const BoardActions({
    required this.open,
    required this.setActive,
    required this.archive,
    required this.pin,
  });

  /// Shows its chat, as a click on its sidebar row does.
  final void Function(BoardThread thread) open;
  final void Function(List<BoardThread> threads, bool active) setActive;
  final void Function(List<BoardThread> threads, bool archived) archive;
  final void Function(List<BoardThread> threads, bool pinned) pin;

  /// [threads] dropped on [column]: made what it is. Nothing for a column
  /// not [BoardColumn.droppable].
  void moveTo(List<BoardThread> threads, BoardColumn column) {
    switch (column) {
      case BoardColumn.active || BoardColumn.idle:
        final archived = [
          for (final t in threads)
            if (t.archived) t,
        ];
        if (archived.isNotEmpty) archive(archived, false);
        setActive(threads, column == BoardColumn.active);
      case BoardColumn.archived:
        archive(threads, true);
      case BoardColumn.working || BoardColumn.needsYou || BoardColumn.done:
    }
  }
}

/// The threads the views show and the companies they are in, filtered.
class BoardData {
  BoardData(this.threads, {this.companies = const []});

  /// Pinned first, then the latest first.
  final List<BoardThread> threads;

  /// Those [threads] are in, in the user's order.
  final List<Company> companies;

  /// Each column's, all of them, in order.
  Map<BoardColumn, List<BoardThread>> get byColumn => {
    for (final column in BoardColumn.values)
      column: [
        for (final t in threads)
          if (t.column == column) t,
      ],
  };

  /// By company, in [companies]' order; those in none (null) last.
  List<(Company?, List<BoardThread>)> get byCompany => [
    for (final company in [...companies, null])
      if ([
            for (final t in threads)
              if (t.company?.name == company?.name) t,
          ]
          case final mine when mine.isNotEmpty)
        (company, mine),
  ];

  /// By project, in the order their latest conversations are.
  List<(Project, List<BoardThread>)> get byProject {
    final groups = <Project, List<BoardThread>>{};
    for (final t in threads) {
      (groups[t.project] ??= []).add(t);
    }
    return [for (final MapEntry(:key, :value) in groups.entries) (key, value)];
  }
}

/// [threads] whose title or project has [query] (any case), in one of
/// [companies] (by name; '' for none) when any is given; ordered as
/// [BoardData.threads] are.
List<BoardThread> filterThreads(
  Iterable<BoardThread> threads, {
  String query = '',
  Set<String> companies = const {},
}) {
  final needle = query.trim().toLowerCase();
  return [
    for (final t in threads)
      if ((companies.isEmpty || companies.contains(t.company?.name ?? '')) &&
          (needle.isEmpty ||
              t.title.toLowerCase().contains(needle) ||
              t.project.name.toLowerCase().contains(needle)))
        t,
  ]..sort(_order);
}

int _order(BoardThread a, BoardThread b) {
  if (a.pinned != b.pinned) return a.pinned ? -1 : 1;
  return b.updatedAt.compareTo(a.updatedAt);
}

/// The companies [threads] are in: in [known]'s order, then the others.
List<Company> companiesOf(Iterable<BoardThread> threads, List<Company> known) {
  final names = {for (final t in threads) ?t.company?.name};
  return [
    for (final c in known)
      if (names.remove(c.name)) c,
    for (final t in threads)
      if (t.company case final c? when names.remove(c.name)) c,
  ];
}

/// [workspace]'s conversations as the sidebar lists them, archived too.
List<BoardThread> boardThreadsOf(Workspace workspace, Companies companies) => [
  for (final thread in workspace.threads)
    if (!thread.untouched &&
        !workspace.isHidden(thread.project) &&
        workspace.listsHost(thread.project.host) &&
        workspace.listsInSidebar(thread))
      BoardThread.of(thread, companies.of(thread.project.path)),
];
