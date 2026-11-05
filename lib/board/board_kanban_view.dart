import 'package:flutter/material.dart';

import '../chat/widgets/hover_builder.dart';
import '../l10n/l10n.dart';
import '../theme/app_theme.dart';
import '../workspace/companies.dart';
import '../workspace/company_dialog.dart' show companyIconOf;
import 'board_card.dart';
import 'board_data.dart';

/// The board's Quadro, as Vibe Kanban's (see CREDITS.md): the columns of
/// [BoardColumn] side by side, each scrolling on its own; cards dragged
/// onto a [BoardColumn.droppable] one become what it is. Folded columns
/// show as thin strips until clicked. With lanes on, a row per company.
class BoardKanbanView extends StatefulWidget {
  const BoardKanbanView({
    super.key,
    required this.data,
    required this.actions,
    this.lanes = false,
  });

  final BoardData data;
  final BoardActions actions;

  /// Split in a row per company at first.
  final bool lanes;

  @override
  State<BoardKanbanView> createState() => _BoardKanbanViewState();
}

class _BoardKanbanViewState extends State<BoardKanbanView> {
  /// Folded columns opened.
  final _opened = <BoardColumn>{};

  /// Lanes folded, by company name ('' for none).
  final _foldedLanes = <String>{};

  late bool _lanes = widget.lanes;

  static const _gap = 8.0;
  static const _strip = 40.0;

  bool _isFolded(BoardColumn column) =>
      column.folded && !_opened.contains(column);

  void _toggle(BoardColumn column) => setState(() {
    if (!_opened.remove(column)) _opened.add(column);
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
          child: _LaneToggle(
            label: l10n.boardKanbanLanes,
            on: _lanes,
            onTap: () => setState(() => _lanes = !_lanes),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final columns = BoardColumn.values;
              final open = columns.where((c) => !_isFolded(c)).length;
              final folded = columns.length - open;
              final room =
                  constraints.maxWidth -
                  24 -
                  folded * _strip -
                  (columns.length - 1) * _gap;
              final width = (room / open).clamp(240.0, 380.0);
              final total =
                  24 +
                  folded * _strip +
                  open * width +
                  (columns.length - 1) * _gap;
              double widthOf(BoardColumn c) => _isFolded(c) ? _strip : width;
              return Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: total,
                    height: constraints.maxHeight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                      child: _lanes
                          ? _buildLanes(widthOf, width)
                          : _buildColumns(widthOf, width),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// One column per [BoardColumn], full height.
  Widget _buildColumns(double Function(BoardColumn) widthOf, double width) {
    final byColumn = widget.data.byColumn;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, column) in BoardColumn.values.indexed) ...[
          if (i > 0) const SizedBox(width: _gap),
          SizedBox(
            width: widthOf(column),
            child: _Column(
              key: ValueKey('board-column-${column.name}'),
              column: column,
              threads: byColumn[column]!,
              folded: _isFolded(column),
              onToggle: () => _toggle(column),
              actions: widget.actions,
              cardWidth: width,
            ),
          ),
        ],
      ],
    );
  }

  /// The headers on top, then a row of cells per company.
  Widget _buildLanes(double Function(BoardColumn) widthOf, double width) {
    final l10n = context.l10n;
    final byColumn = widget.data.byColumn;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            for (final (i, column) in BoardColumn.values.indexed) ...[
              if (i > 0) const SizedBox(width: _gap),
              SizedBox(
                width: widthOf(column),
                child: _Panel(
                  column: column,
                  child: _Header(
                    column: column,
                    count: byColumn[column]!.length,
                    folded: _isFolded(column),
                    vertical: false,
                    onToggle: column.folded ? () => _toggle(column) : null,
                  ),
                ),
              ),
            ],
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 4),
            children: [
              for (final (company, threads) in widget.data.byCompany)
                _Lane(
                  key: ValueKey('board-lane-${company?.name ?? ''}'),
                  company: company,
                  label: company?.name ?? l10n.officeNoCompany,
                  count: threads.length,
                  folded: _foldedLanes.contains(company?.name ?? ''),
                  onToggle: () => setState(() {
                    final name = company?.name ?? '';
                    if (!_foldedLanes.remove(name)) _foldedLanes.add(name);
                  }),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final (i, column)
                            in BoardColumn.values.indexed) ...[
                          if (i > 0) const SizedBox(width: _gap),
                          SizedBox(
                            width: widthOf(column),
                            child: _Drop(
                              key: ValueKey(
                                'board-lane-cell-${company?.name ?? ''}-${column.name}',
                              ),
                              column: column,
                              actions: widget.actions,
                              builder: (highlight) => _Cell(
                                column: column,
                                highlight: highlight,
                                folded: _isFolded(column),
                                threads: [
                                  for (final t in byColumn[column]!)
                                    if (t.company?.name == company?.name) t,
                                ],
                                actions: widget.actions,
                                cardWidth: width,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// How a column takes what is dragged over it.
enum _Highlight { none, accepts, refuses }

/// [builder]'s column, taking the cards dropped on it: [BoardActions.moveTo].
class _Drop extends StatelessWidget {
  const _Drop({
    super.key,
    required this.column,
    required this.actions,
    required this.builder,
  });

  final BoardColumn column;
  final BoardActions actions;
  final Widget Function(_Highlight highlight) builder;

  @override
  Widget build(BuildContext context) => DragTarget<BoardThread>(
    onWillAcceptWithDetails: (details) =>
        column.droppable && details.data.column != column,
    onAcceptWithDetails: (details) => actions.moveTo([details.data], column),
    builder: (context, accepted, rejected) => builder(
      accepted.isNotEmpty
          ? _Highlight.accepts
          : rejected.isNotEmpty
          ? _Highlight.refuses
          : _Highlight.none,
    ),
  );
}

/// A column's ground: its color, faint, over the surface.
class _Panel extends StatelessWidget {
  const _Panel({
    required this.column,
    required this.child,
    this.highlight = _Highlight.none,
  });

  final BoardColumn column;
  final _Highlight highlight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = boardColumnColor(column);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          color.withValues(
            alpha: highlight == _Highlight.accepts ? 0.12 : 0.035,
          ),
          AppColors.background,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: switch (highlight) {
            _Highlight.accepts => color,
            _Highlight.refuses => AppColors.removed.withValues(alpha: 0.6),
            _Highlight.none => AppColors.partBorder,
          },
        ),
      ),
      child: child,
    );
  }
}

/// A whole column: its header, then its cards, scrolling; a strip when
/// [folded].
class _Column extends StatelessWidget {
  const _Column({
    super.key,
    required this.column,
    required this.threads,
    required this.folded,
    required this.onToggle,
    required this.actions,
    required this.cardWidth,
  });

  final BoardColumn column;
  final List<BoardThread> threads;
  final bool folded;
  final VoidCallback onToggle;
  final BoardActions actions;
  final double cardWidth;

  @override
  Widget build(BuildContext context) => _Drop(
    column: column,
    actions: actions,
    builder: (highlight) => _Panel(
      column: column,
      highlight: highlight,
      child: folded
          ? _Header(
              column: column,
              count: threads.length,
              folded: true,
              vertical: true,
              onToggle: onToggle,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(
                  column: column,
                  count: threads.length,
                  folded: false,
                  vertical: false,
                  onToggle: column.folded ? onToggle : null,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: threads.isEmpty
                            ? _Empty(column: column)
                            : ListView.separated(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                itemCount: threads.length,
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 6),
                                itemBuilder: (context, i) => _DraggableCard(
                                  thread: threads[i],
                                  actions: actions,
                                  width: cardWidth - 16,
                                ),
                              ),
                      ),
                      if (highlight == _Highlight.refuses)
                        const Positioned.fill(child: _Refused()),
                    ],
                  ),
                ),
              ],
            ),
    ),
  );
}

/// A lane's cell of [column]: its cards, not scrolling on their own.
class _Cell extends StatelessWidget {
  const _Cell({
    required this.column,
    required this.highlight,
    required this.folded,
    required this.threads,
    required this.actions,
    required this.cardWidth,
  });

  final BoardColumn column;
  final _Highlight highlight;
  final bool folded;
  final List<BoardThread> threads;
  final BoardActions actions;
  final double cardWidth;

  @override
  Widget build(BuildContext context) => _Panel(
    column: column,
    highlight: highlight,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: folded
          ? Center(
              child: Text(
                threads.isEmpty ? '' : '${threads.length}',
                style: TextStyle(color: AppColors.textFaint, fontSize: 11),
              ),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final (i, t) in threads.indexed) ...[
                        if (i > 0) const SizedBox(height: 6),
                        _DraggableCard(
                          thread: t,
                          actions: actions,
                          width: cardWidth - 16,
                        ),
                      ],
                    ],
                  ),
                ),
                if (highlight == _Highlight.refuses)
                  const Positioned.fill(child: _Refused()),
              ],
            ),
    ),
  );
}

/// A column's top: its dot, name and count; written down when [vertical],
/// as a folded column's strip. Clicked, it folds or opens ([onToggle]).
class _Header extends StatelessWidget {
  const _Header({
    required this.column,
    required this.count,
    required this.folded,
    required this.vertical,
    this.onToggle,
  });

  final BoardColumn column;
  final int count;
  final bool folded;
  final bool vertical;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final label = boardColumnLabel(column, l10n);
    final dot = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: boardColumnColor(column),
        shape: BoxShape.circle,
      ),
    );
    final name = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
    );
    final badge = _Count(count);
    final chevron = onToggle == null
        ? null
        : Icon(
            folded ? Icons.chevron_right : Icons.chevron_left,
            size: 16,
            color: AppColors.textMuted,
          );
    final child = vertical
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                ?chevron,
                const SizedBox(height: 6),
                dot,
                const SizedBox(height: 10),
                RotatedBox(quarterTurns: 1, child: name),
                const SizedBox(height: 10),
                badge,
              ],
            ),
          )
        : folded
        ? SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [?chevron, const SizedBox(width: 2), dot],
            ),
          )
        : SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  dot,
                  const SizedBox(width: 8),
                  Flexible(child: name),
                  const SizedBox(width: 8),
                  badge,
                  const Spacer(),
                  ?chevron,
                ],
              ),
            ),
          );
    if (onToggle == null) return child;
    return Tooltip(
      message: folded ? l10n.boardKanbanExpand(label) : l10n.boardKanbanFold,
      waitDuration: const Duration(milliseconds: 500),
      child: HoverBuilder(
        cursor: SystemMouseCursors.click,
        builder: (context, hovered) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onToggle,
          child: child,
        ),
      ),
    );
  }
}

/// How many: a pill.
class _Count extends StatelessWidget {
  const _Count(this.count);

  final int count;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    decoration: BoxDecoration(
      color: AppColors.hover,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      '$count',
      style: TextStyle(
        color: AppColors.textMuted,
        fontSize: 11,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    ),
  );
}

/// A card to drag: a shadowed copy follows the pointer, the card left
/// faint. A click with no drag still opens it.
class _DraggableCard extends StatelessWidget {
  const _DraggableCard({
    required this.thread,
    required this.actions,
    required this.width,
  });

  final BoardThread thread;
  final BoardActions actions;
  final double width;

  @override
  Widget build(BuildContext context) {
    final card = ThreadCard(thread: thread, actions: actions);
    return Draggable<BoardThread>(
      data: thread,
      feedback: Material(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(6),
        child: SizedBox(width: width, child: card),
      ),
      childWhenDragging: Opacity(opacity: 0.35, child: card),
      child: card,
    );
  }
}

/// A column with nothing in it.
class _Empty extends StatelessWidget {
  const _Empty({required this.column});

  final BoardColumn column;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Align(
      alignment: const Alignment(0, -0.6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          column.droppable ? l10n.boardKanbanDropHere : l10n.boardKanbanEmpty,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textFaint, fontSize: 11.5),
        ),
      ),
    );
  }
}

/// Over a column a card can't be dropped on.
class _Refused extends StatelessWidget {
  const _Refused();

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      alignment: const Alignment(0, -0.5),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.block, size: 14, color: AppColors.removed),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              context.l10n.boardKanbanNotAllowed,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, fontSize: 11.5),
            ),
          ),
        ],
      ),
    ),
  );
}

/// A company's lane: its icon, name and count over its row of cells;
/// folded, the header alone.
class _Lane extends StatelessWidget {
  const _Lane({
    super.key,
    required this.company,
    required this.label,
    required this.count,
    required this.folded,
    required this.onToggle,
    required this.child,
  });

  final Company? company;
  final String label;
  final int count;
  final bool folded;
  final VoidCallback onToggle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = switch (company?.color) {
      final color? => Color(color),
      null => AppColors.textMuted,
    };
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HoverBuilder(
            cursor: SystemMouseCursors.click,
            builder: (context, hovered) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onToggle,
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: hovered ? 0.12 : 0.07),
                  borderRadius: BorderRadius.circular(6),
                  border: Border(left: BorderSide(color: color, width: 3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      folded ? Icons.chevron_right : Icons.expand_more,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    if (company case final company?) ...[
                      companyIconOf(company, size: 13),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _Count(count),
                  ],
                ),
              ),
            ),
          ),
          if (!folded) ...[const SizedBox(height: 6), child],
        ],
      ),
    );
  }
}

/// The lanes' switch: a chip, lit while on.
class _LaneToggle extends StatelessWidget {
  const _LaneToggle({
    required this.label,
    required this.on,
    required this.onTap,
  });

  final String label;
  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    toggled: on,
    label: label,
    child: HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: on
                ? AppColors.accent.withValues(alpha: 0.16)
                : hovered
                ? AppColors.hover
                : null,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: on ? AppColors.accent : AppColors.partBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.view_agenda_outlined,
                size: 13,
                color: on ? AppColors.accent : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: on ? AppColors.text : AppColors.textMuted,
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
