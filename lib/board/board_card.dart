import 'package:flutter/material.dart';

import '../chat/widgets/hover_builder.dart';
import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show StatusIndicator, relativeTime;
import '../sidebar/sidebar_menu.dart';
import '../theme/app_theme.dart';
import '../theme/workbench_theme.dart' show themeColors;
import '../workspace/companies.dart';
import '../workspace/company_dialog.dart' show companyIconOf;
import '../workspace/workspace.dart';
import 'board_data.dart';

/// [column]'s color, its dot and its header's tint: as Vibe Kanban's
/// statuses (In progress, In review, Done...), in the theme's where it
/// has one.
Color boardColumnColor(BoardColumn column) => switch (column) {
  BoardColumn.working => AppColors.accent,
  BoardColumn.needsYou => StatusIndicator.needsInputColor,
  BoardColumn.done => AppColors.added,
  // Vibe Kanban's "In review" violet.
  BoardColumn.active => const Color(0xff9b6cf6),
  BoardColumn.idle => AppColors.textMuted,
  BoardColumn.archived => AppColors.textFaint,
};

/// [column]'s name, in [l10n]'s language.
String boardColumnLabel(BoardColumn column, AppLocalizations l10n) =>
    switch (column) {
      BoardColumn.working => l10n.boardColumnWorking,
      BoardColumn.needsYou => l10n.boardColumnNeedsYou,
      BoardColumn.done => l10n.boardColumnDone,
      BoardColumn.active => l10n.boardColumnActive,
      BoardColumn.idle => l10n.boardColumnIdle,
      BoardColumn.archived => l10n.boardColumnArchived,
    };

/// A kernel's short name, on its badge.
String kernelLabel(String? kernel) => switch (kernel) {
  'claude-code' || null => 'Claude',
  'codex' => 'Codex',
  final other => other,
};

/// What the sidebar's row menu has for [thread]: pin, activate, archive.
List<SidebarMenuItem> boardThreadItems(
  BoardThread thread,
  BoardActions actions,
  AppLocalizations l10n,
) => [
  if (!thread.archived)
    SidebarMenuItem(
      thread.pinned ? l10n.sidebarUnpin : l10n.sidebarPin,
      icon: thread.pinned ? Icons.push_pin : Icons.push_pin_outlined,
      onSelected: () => actions.pin([thread], !thread.pinned),
    ),
  SidebarMenuItem(
    thread.active ? l10n.sidebarDeactivate : l10n.sidebarActivate,
    icon: Icons.bolt_outlined,
    onSelected: () => actions.setActive([thread], !thread.active),
  ),
  SidebarMenuItem(
    thread.archived ? l10n.sidebarUnarchive : l10n.sidebarArchive,
    icon: Icons.inventory_2_outlined,
    onSelected: () => actions.archive([thread], !thread.archived),
  ),
];

/// [thread]'s status, as the sidebar shows it; a dot of its column's
/// color while nothing goes on.
class BoardStatusDot extends StatelessWidget {
  const BoardStatusDot(this.thread, {super.key});

  final BoardThread thread;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 13,
    height: 13,
    child: Center(
      child: thread.status == ThreadStatus.idle || thread.archived
          ? Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: boardColumnColor(thread.column),
                shape: BoxShape.circle,
              ),
            )
          : StatusIndicator(thread.status),
    ),
  );
}

/// A project's name in its company's color, its icon first.
class BoardProjectChip extends StatelessWidget {
  const BoardProjectChip({super.key, required this.project, this.company});

  final Project project;
  final Company? company;

  @override
  Widget build(BuildContext context) {
    final color = switch (company?.color) {
      final color? => Color(color),
      null => AppColors.textMuted,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (company case final company?) ...[
            companyIconOf(company, size: 11),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              project.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.text, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

/// Lines added and removed, as the sidebar shows them.
class BoardDiff extends StatelessWidget {
  const BoardDiff(this.diff, {super.key});

  final ({int added, int removed}) diff;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '+${diff.added}',
          style: TextStyle(color: themeColors['chat.linesAddedForeground']),
        ),
        TextSpan(
          text: ' −${diff.removed}',
          style: TextStyle(color: themeColors['chat.linesRemovedForeground']),
        ),
      ],
    ),
    maxLines: 1,
    style: const TextStyle(
      fontSize: 11,
      fontFeatures: [FontFeature.tabularFigures()],
    ),
  );
}

/// Who runs it: Claude, Codex.
class BoardKernelBadge extends StatelessWidget {
  const BoardKernelBadge(this.kernel, {super.key});

  final String? kernel;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.partBorder),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      kernelLabel(kernel),
      style: TextStyle(color: AppColors.textMuted, fontSize: 10.5),
    ),
  );
}

/// A conversation as a card, as Vibe Kanban's (see CREDITS.md): its
/// status and project, its title in up to two lines, then its changes, who
/// runs it and when it last did something. Clicked, its chat opens; right
/// clicked, the sidebar row's menu.
class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.thread,
    required this.actions,
    this.showProject = true,
    this.selected = false,
  });

  final BoardThread thread;
  final BoardActions actions;

  /// Its project's chip shows: not where the cards are by project.
  final bool showProject;

  /// Outlined, as the one open.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final faint = TextStyle(color: AppColors.textFaint, fontSize: 11);
    return SidebarMenu(
      items: () => boardThreadItems(thread, actions, l10n),
      builder: (context, menu) => HoverBuilder(
        cursor: SystemMouseCursors.click,
        builder: (context, hovered) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => actions.open(thread),
          onSecondaryTapUp: (details) => menu.open(details.globalPosition),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: BoxDecoration(
              color: hovered ? AppColors.hover : AppColors.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: selected
                    ? themeColors['focusBorder']
                    : hovered
                    ? AppColors.borderStrong
                    : AppColors.partBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    BoardStatusDot(thread),
                    const SizedBox(width: 6),
                    Expanded(
                      child: showProject
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: BoardProjectChip(
                                project: thread.project,
                                company: thread.company,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    if (thread.pinned)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.push_pin,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  thread.thread?.localizedTitle(l10n) ?? thread.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 12.5,
                    height: 1.35,
                    fontWeight: thread.status == ThreadStatus.unread
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (thread.diff case final diff?) BoardDiff(diff),
                    const Spacer(),
                    BoardKernelBadge(thread.kernel),
                    const SizedBox(width: 6),
                    Text(
                      relativeTime(thread.updatedAt, DateTime.now(), l10n),
                      style: faint,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
