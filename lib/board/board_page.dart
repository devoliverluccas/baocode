import 'package:flutter/material.dart';

import '../chat/widgets/hover_builder.dart';
import '../ide/ide_input.dart';
import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show SidebarIconButton;
import '../theme/app_theme.dart';
import '../theme/codicons.dart';
import '../usage/ui/usage_filters.dart' show UsageSegmented;
import '../workspace/companies.dart';
import '../workspace/company_dialog.dart' show companyIconOf;
import '../workspace/islands.dart';
import '../workspace/title_bar_double_click.dart';
import '../workspace/workspace.dart';
import 'board_cards_view.dart';
import 'board_data.dart';
import 'board_kanban_view.dart';
import 'board_table_view.dart';

/// The board, in place of the conversations as the office is: the
/// sidebar's conversations as a kanban, cards or a table (see
/// [BoardView]), filtered by company and by text.
class BoardPage extends StatefulWidget {
  const BoardPage({
    super.key,
    required this.workspace,
    required this.onOpenAgent,
    required this.onClose,
    this.leading,
    this.titleBarInset = 12,
    this.island,
    this.threads,
  });

  final Workspace workspace;

  /// A card was clicked: its conversation opens.
  final ValueChanged<AgentThread> onOpenAgent;
  final VoidCallback onClose;

  /// The title bar's first widget, right of [titleBarInset]: the sidebar's
  /// toggle while it is hidden.
  final Widget? leading;
  final double titleBarInset;

  /// The card it is on, if any.
  final Color? island;

  /// Shown in place of [workspace]'s: tests'.
  final List<BoardThread>? threads;

  @override
  State<BoardPage> createState() => BoardPageState();
}

class BoardPageState extends State<BoardPage> {
  final _search = TextEditingController();

  /// The companies picked, by name ('' for none); none: all.
  final Set<String> _companies = {};

  BoardView get view =>
      BoardView.values.asNameMap()[widget.workspace.boardView] ??
      BoardView.kanban;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  late final BoardActions _actions = BoardActions(
    open: (t) {
      if (t.thread case final thread?) widget.onOpenAgent(thread);
    },
    setActive: (threads, active) =>
        widget.workspace.setActive(_agents(threads), active),
    archive: (threads, archived) =>
        widget.workspace.setArchivedAll(_agents(threads), archived),
    pin: (threads, pinned) =>
        widget.workspace.setPinnedAll(_agents(threads), pinned),
    create: (project) =>
        widget.onOpenAgent(widget.workspace.create(project: project)),
  );

  static List<AgentThread> _agents(List<BoardThread> threads) => [
    for (final t in threads) ?t.thread,
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.workspace,
        Companies.instance,
        _search,
      ]),
      builder: (context, _) {
        final all =
            widget.threads ??
            boardThreadsOf(widget.workspace, Companies.instance);
        final companies = companiesOf(all, Companies.instance.list);
        final data = BoardData(
          filterThreads(all, query: _search.text, companies: _companies),
          companies: companies,
        );
        final body = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFilters(companies, all.any((t) => t.company == null)),
            Expanded(
              child: data.threads.isEmpty
                  ? Center(
                      child: Text(
                        context.l10n.boardEmpty,
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    )
                  : switch (view) {
                      BoardView.kanban => BoardKanbanView(
                        data: data,
                        actions: _actions,
                      ),
                      BoardView.cards => BoardCardsView(
                        data: data,
                        actions: _actions,
                      ),
                      BoardView.table => BoardTableView(
                        data: data,
                        actions: _actions,
                      ),
                    },
            ),
          ],
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleBar(),
            Expanded(
              child: switch (widget.island) {
                final color? => Island(color: color, child: body),
                null => body,
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitleBar() {
    final l10n = context.l10n;
    return TitleBarDoubleClick(
      child: SizedBox(
        height: AppMetrics.titleBarHeight,
        child: Row(
          children: [
            SizedBox(width: widget.titleBarInset),
            if (widget.leading case final leading?) ...[
              leading,
              const SizedBox(width: 10),
            ],
            Text(
              l10n.boardTitle,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            UsageSegmented<BoardView>(
              dense: true,
              value: view,
              segments: [
                (value: BoardView.kanban, label: l10n.boardViewKanban),
                (value: BoardView.cards, label: l10n.boardViewCards),
                (value: BoardView.table, label: l10n.boardViewTable),
              ],
              onChanged: (view) => widget.workspace.boardView = view.name,
            ),
            const Spacer(),
            SidebarIconButton(
              icon: Codicons.close,
              tooltip: l10n.boardClose,
              onTap: widget.onClose,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  /// As Vibe Kanban's filter bar: the companies to show, and the search.
  Widget _buildFilters(List<Company> companies, bool someInNone) {
    final l10n = context.l10n;
    void toggle(String name) => setState(() {
      if (!_companies.remove(name)) _companies.add(name);
    });
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _Chip(
                  label: l10n.boardAllCompanies,
                  selected: _companies.isEmpty,
                  onTap: () => setState(_companies.clear),
                ),
                for (final company in companies)
                  _Chip(
                    label: company.name,
                    icon: companyIconOf(company, size: 12),
                    selected: _companies.contains(company.name),
                    onTap: () => toggle(company.name),
                  ),
                if (someInNone)
                  _Chip(
                    label: l10n.officeNoCompany,
                    selected: _companies.contains(''),
                    onTap: () => toggle(''),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 220,
            child: IdeInputBox(
              controller: _search,
              placeholder: l10n.boardSearch,
              semanticsLabel: l10n.boardSearch,
              radius: Islands.controlRadius,
            ),
          ),
        ],
      ),
    );
  }
}

/// A filter that is on or off.
class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    child: HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.surfaceRaised
                : hovered
                ? AppColors.hover
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.borderStrong : AppColors.partBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon case final icon?) ...[icon, const SizedBox(width: 5)],
              Text(
                label,
                style: TextStyle(
                  color: selected || hovered
                      ? AppColors.text
                      : AppColors.textMuted,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
