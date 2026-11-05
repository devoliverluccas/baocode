import 'package:flutter/material.dart';

import '../chat/widgets/hover_builder.dart';
import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show relativeTime;
import '../sidebar/sidebar_menu.dart';
import '../theme/app_theme.dart';
import '../theme/codicons.dart';
import '../workspace/companies.dart';
import '../workspace/company_dialog.dart' show companyIconOf;
import '../workspace/workspace.dart';
import 'board_card.dart';
import 'board_data.dart';

/// The board's Cartões: a card per project, under its company's heading;
/// those with a chat waiting on the user first.
class BoardCardsView extends StatelessWidget {
  const BoardCardsView({super.key, required this.data, required this.actions});

  final BoardData data;
  final BoardActions actions;

  /// A card's narrowest; the grid fits as many as this allows.
  static const minCardWidth = 300.0;
  static const gap = 12.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - 32;
        final columns = ((width + gap) / (minCardWidth + gap)).floor().clamp(
          1,
          99,
        );
        final cardWidth = (width - gap * (columns - 1)) / columns;
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            for (final (company, threads) in data.byCompany) ...[
              _CompanyHeading(
                company: company,
                label: company?.name ?? l10n.officeNoCompany,
                projects: projectsOf(threads).length,
              ),
              Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final (project, threads) in projectsOf(threads))
                    SizedBox(
                      width: cardWidth,
                      child: ProjectCard(
                        key: ValueKey(project.path),
                        project: project,
                        company: company,
                        threads: threads,
                        actions: actions,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ],
        );
      },
    );
  }
}

/// [threads] by project, newest first in each: those with one waiting on
/// the user first, then by their latest.
List<(Project, List<BoardThread>)> projectsOf(List<BoardThread> threads) {
  final projects = [
    for (final (project, mine) in BoardData(threads).byProject)
      (project, [...mine]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt))),
  ];
  bool waits(List<BoardThread> ts) =>
      ts.any((t) => t.column == BoardColumn.needsYou);
  projects.sort((a, b) {
    if (waits(a.$2) != waits(b.$2)) return waits(a.$2) ? -1 : 1;
    return b.$2.first.updatedAt.compareTo(a.$2.first.updatedAt);
  });
  return projects;
}

/// A company's name in its color, over its projects' cards.
class _CompanyHeading extends StatelessWidget {
  const _CompanyHeading({
    required this.company,
    required this.label,
    required this.projects,
  });

  final Company? company;
  final String label;
  final int projects;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(2, 8, 2, 10),
    child: Row(
      children: [
        if (company case final company?)
          companyIconOf(company, size: 15)
        else
          Icon(Codicons.folder, size: 15, color: AppColors.textMuted),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: _colorOf(company),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$projects',
          style: TextStyle(color: AppColors.textFaint, fontSize: 11.5),
        ),
        const SizedBox(width: 12),
        Expanded(child: Container(height: 1, color: AppColors.partBorder)),
      ],
    ),
  );
}

Color _colorOf(Company? company) => switch (company?.color) {
  final color? => Color(color),
  null => AppColors.textMuted,
};

/// A project's card: what its chats do, its three latest (all of them,
/// its heading clicked), the changes its active ones made and a new chat.
class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.threads,
    required this.actions,
    this.company,
  });

  final Project project;
  final Company? company;

  /// Newest first.
  final List<BoardThread> threads;
  final BoardActions actions;

  /// Chats listed while folded.
  static const shown = 3;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final threads = widget.threads;
    // Folded, the archived ones wait for "show all".
    final live = [
      for (final t in threads)
        if (!t.archived) t,
    ];
    final folded = live.take(ProjectCard.shown).toList();
    final listed = _expanded ? threads : folded;
    final counts = {
      for (final column in const [
        BoardColumn.working,
        BoardColumn.needsYou,
        BoardColumn.done,
        BoardColumn.active,
      ])
        column: threads.where((t) => t.column == column).length,
    };
    var added = 0, removed = 0;
    for (final t in threads) {
      if (t.active && !t.archived && t.diff != null) {
        added += t.diff!.added;
        removed += t.diff!.removed;
      }
    }
    final accent = _colorOf(widget.company);
    final waits = counts[BoardColumn.needsYou]! > 0;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: waits
              ? boardColumnColor(BoardColumn.needsYou).withValues(alpha: 0.45)
              : AppColors.partBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 3, color: accent.withValues(alpha: 0.85)),
          _buildHeading(l10n, accent, threads.length),
          if (counts.values.any((n) => n > 0))
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  for (final MapEntry(key: column, value: n) in counts.entries)
                    if (n > 0) _Count(column: column, count: n),
                ],
              ),
            ),
          Container(height: 1, color: AppColors.partBorder),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final t in listed)
                  _ChatRow(thread: t, actions: widget.actions),
              ],
            ),
          ),
          if (threads.length > folded.length)
            _TextButton(
              label: _expanded
                  ? l10n.boardCardsShowLess
                  : l10n.boardCardsShowAll(threads.length),
              onTap: () => setState(() => _expanded = !_expanded),
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
            ),
          Container(height: 1, color: AppColors.partBorder),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 6, 6),
            child: Row(
              children: [
                if (added > 0 || removed > 0)
                  Tooltip(
                    message: l10n.boardCardsActiveDiff,
                    child: BoardDiff((added: added, removed: removed)),
                  ),
                const Spacer(),
                if (widget.actions.create case final create?)
                  _TextButton(
                    label: l10n.boardCardsNewChat,
                    icon: Icons.add_rounded,
                    onTap: () => create(widget.project),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Its name, its chats' number and when one last did something; clicked,
  /// it shows all of them or folds back.
  Widget _buildHeading(
    AppLocalizations l10n,
    Color accent,
    int total,
  ) => HoverBuilder(
    cursor: SystemMouseCursors.click,
    builder: (context, hovered) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        color: hovered ? AppColors.hover : null,
        padding: const EdgeInsets.fromLTRB(12, 10, 10, 8),
        child: Row(
          children: [
            Icon(Codicons.folder, size: 15, color: accent),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${l10n.boardCardsChats(total)} · '
                    '${relativeTime(widget.threads.first.updatedAt, DateTime.now(), l10n)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.textFaint, fontSize: 11),
                  ),
                ],
              ),
            ),
            Icon(
              _expanded ? Codicons.chevronUp : Codicons.chevronDown,
              size: 14,
              color: hovered ? AppColors.text : AppColors.textFaint,
            ),
          ],
        ),
      ),
    ),
  );
}

/// How many of a project's chats are in [column], after its dot and name.
class _Count extends StatelessWidget {
  const _Count({required this.column, required this.count});

  final BoardColumn column;
  final int count;

  @override
  Widget build(BuildContext context) {
    final color = boardColumnColor(column);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            boardColumnLabel(column, context.l10n),
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// A chat in its project's card: clicked, it opens; right clicked, the
/// sidebar row's menu.
class _ChatRow extends StatelessWidget {
  const _ChatRow({required this.thread, required this.actions});

  final BoardThread thread;
  final BoardActions actions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SidebarMenu(
      items: () => boardThreadItems(thread, actions, l10n),
      builder: (context, menu) => HoverBuilder(
        cursor: SystemMouseCursors.click,
        builder: (context, hovered) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => actions.open(thread),
          onSecondaryTapUp: (details) => menu.open(details.globalPosition),
          child: Container(
            height: 28,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: hovered ? AppColors.hover : null,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                BoardStatusDot(thread),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    thread.thread?.localizedTitle(l10n) ?? thread.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: thread.archived
                          ? AppColors.textMuted
                          : AppColors.text,
                      fontSize: 12.5,
                      fontWeight: thread.status == ThreadStatus.unread
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (thread.pinned)
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Icon(
                      Icons.push_pin,
                      size: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  relativeTime(thread.updatedAt, DateTime.now(), l10n),
                  style: TextStyle(
                    color: AppColors.textFaint,
                    fontSize: 11,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A small link-like button: "Novo chat", "Ver todas".
class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.padding = EdgeInsets.zero,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Semantics(
        button: true,
        child: HoverBuilder(
          cursor: SystemMouseCursors.click,
          builder: (context, hovered) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: hovered ? AppColors.hover : null,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon case final icon?) ...[
                    Icon(
                      icon,
                      size: 14,
                      color: hovered ? AppColors.text : AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: hovered ? AppColors.text : AppColors.textMuted,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
