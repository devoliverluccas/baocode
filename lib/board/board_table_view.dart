import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../chat/widgets/hover_builder.dart';
import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show relativeTime;
import '../sidebar/sidebar_menu.dart';
import '../theme/app_theme.dart';
import '../theme/codicons.dart';
import '../theme/workbench_theme.dart' show themeColors;
import '../workspace/companies.dart';
import '../workspace/company_dialog.dart' show companyIconOf;
import '../workspace/workspace.dart' show ThreadStatus;
import 'board_card.dart';
import 'board_data.dart';

/// What the table sorts by: one a column.
enum BoardTableSort {
  status,
  title,
  project,
  company,
  kernel,
  diff,
  updated,
  pinned,
}

/// The order of [BoardColumn]s by status: what needs the user first.
const _statusRank = {
  BoardColumn.needsYou: 0,
  BoardColumn.working: 1,
  BoardColumn.done: 2,
  BoardColumn.active: 3,
  BoardColumn.idle: 4,
  BoardColumn.archived: 5,
};

/// [threads] sorted by [by], [ascending] or not; the latest first among
/// equals.
List<BoardThread> sortBoardThreads(
  Iterable<BoardThread> threads,
  BoardTableSort by, {
  bool ascending = true,
}) {
  int text(String a, String b) => a.toLowerCase().compareTo(b.toLowerCase());
  int key(BoardThread a, BoardThread b) => switch (by) {
    BoardTableSort.status => _statusRank[a.column]!.compareTo(
      _statusRank[b.column]!,
    ),
    BoardTableSort.title => text(a.title, b.title),
    BoardTableSort.project => text(a.project.name, b.project.name),
    // Those in none last.
    BoardTableSort.company => text(
      a.company?.name ?? '\u{10FFFF}',
      b.company?.name ?? '\u{10FFFF}',
    ),
    BoardTableSort.kernel => text(kernelLabel(a.kernel), kernelLabel(b.kernel)),
    BoardTableSort.diff => _changes(a).compareTo(_changes(b)),
    BoardTableSort.updated => a.updatedAt.compareTo(b.updatedAt),
    BoardTableSort.pinned => (a.pinned ? 1 : 0).compareTo(b.pinned ? 1 : 0),
  };
  return [...threads]..sort((a, b) {
    final c = ascending ? key(a, b) : key(b, a);
    return c != 0 ? c : b.updatedAt.compareTo(a.updatedAt);
  });
}

int _changes(BoardThread t) => switch (t.diff) {
  final d? => d.added + d.removed,
  null => -1,
};

/// The board's Tabela, as Vibe Kanban's issue list (see CREDITS.md): one
/// dense row a conversation, sorted by the header clicked. Clicked, a row
/// opens its chat; right clicked, the card's menu. Its checkboxes, and
/// shift or ctrl clicks, select rows for the bar above to act on.
class BoardTableView extends StatefulWidget {
  const BoardTableView({super.key, required this.data, required this.actions});

  final BoardData data;
  final BoardActions actions;

  @override
  State<BoardTableView> createState() => _BoardTableViewState();
}

/// A column: what it sorts by, its width (null: the rest), its label.
typedef _Column = ({BoardTableSort sort, double? width, String label});

class _BoardTableViewState extends State<BoardTableView> {
  var _sort = BoardTableSort.status;
  var _ascending = true;

  /// The rows selected, by [_keyOf]: they outlive the data rebuilt.
  final _selected = <Object>{};

  /// The row a shift click selects from.
  Object? _anchor;

  static Object _keyOf(BoardThread t) =>
      t.thread ?? '${t.project.path}\u0000${t.title}';

  void _sortBy(BoardTableSort sort) => setState(() {
    if (_sort == sort) {
      _ascending = !_ascending;
    } else {
      _sort = sort;
      // Numbers and times: the most first.
      _ascending = switch (sort) {
        BoardTableSort.diff ||
        BoardTableSort.updated ||
        BoardTableSort.pinned => false,
        _ => true,
      };
    }
  });

  /// [t] toggled; with shift, every row from the anchor to it selected.
  void _select(List<BoardThread> rows, BoardThread t, {bool range = false}) {
    final key = _keyOf(t);
    setState(() {
      final from = rows.indexWhere((r) => _keyOf(r) == _anchor);
      if (range && from >= 0) {
        final to = rows.indexOf(t);
        final (a, b) = from < to ? (from, to) : (to, from);
        _selected.addAll(rows.sublist(a, b + 1).map(_keyOf));
      } else if (!_selected.remove(key)) {
        _selected.add(key);
      }
      _anchor = key;
    });
  }

  void _tap(List<BoardThread> rows, BoardThread t) {
    final keys = HardwareKeyboard.instance;
    if (keys.isShiftPressed) {
      _select(rows, t, range: true);
    } else if (keys.isControlPressed || keys.isMetaPressed) {
      _select(rows, t);
    } else {
      widget.actions.open(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rows = sortBoardThreads(
      widget.data.threads,
      _sort,
      ascending: _ascending,
    );
    final selected = [
      for (final t in rows)
        if (_selected.contains(_keyOf(t))) t,
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1100;
        final List<_Column> columns = [
          (
            sort: BoardTableSort.status,
            width: 140,
            label: l10n.boardTableStatus,
          ),
          (
            sort: BoardTableSort.title,
            width: null,
            label: l10n.boardTableTitle,
          ),
          (
            sort: BoardTableSort.project,
            width: wide ? 190 : 160,
            label: l10n.boardTableProject,
          ),
          // Narrow, the project's chip has the company's color and icon.
          if (wide)
            (
              sort: BoardTableSort.company,
              width: 130,
              label: l10n.boardTableCompany,
            ),
          (
            sort: BoardTableSort.kernel,
            width: 76,
            label: l10n.boardTableKernel,
          ),
          (
            sort: BoardTableSort.diff,
            width: 100,
            label: l10n.boardTableChanges,
          ),
          (
            sort: BoardTableSort.updated,
            width: 92,
            label: l10n.boardTableUpdated,
          ),
          (sort: BoardTableSort.pinned, width: 36, label: ''),
        ];
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (selected.isNotEmpty) ...[
                _BulkBar(
                  selected: selected,
                  actions: widget.actions,
                  onClear: () => setState(_selected.clear),
                ),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.partBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _header(columns, rows, selected.length),
                      Divider(height: 1, color: AppColors.partBorder),
                      Expanded(
                        child: ListView.builder(
                          itemCount: rows.length,
                          itemExtent: 38,
                          itemBuilder: (context, i) => _row(
                            columns,
                            rows,
                            rows[i],
                            last: i == rows.length - 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _cells(List<_Column> columns, Widget Function(_Column) cell) => Row(
    children: [
      for (final c in columns)
        if (c.width case final width?)
          SizedBox(width: width, child: cell(c))
        else
          Expanded(child: cell(c)),
    ],
  );

  Widget _header(List<_Column> columns, List<BoardThread> rows, int selected) {
    final all = selected == rows.length;
    return Container(
      height: 34,
      color: AppColors.surface,
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Center(
              child: _Checkbox(
                checked: selected == 0 ? false : (all ? true : null),
                tooltip: context.l10n.boardTableSelectAll,
                onTap: () => setState(() {
                  if (all) {
                    _selected.clear();
                  } else {
                    _selected.addAll(rows.map(_keyOf));
                  }
                }),
              ),
            ),
          ),
          Expanded(
            child: _cells(
              columns,
              (c) => _HeaderCell(
                label: c.label,
                icon: c.sort == BoardTableSort.pinned ? Icons.push_pin : null,
                tooltip: c.sort == BoardTableSort.pinned
                    ? context.l10n.boardTablePinned
                    : null,
                sorted: _sort == c.sort ? _ascending : null,
                onTap: () => _sortBy(c.sort),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(
    List<_Column> columns,
    List<BoardThread> rows,
    BoardThread t, {
    required bool last,
  }) {
    final l10n = context.l10n;
    final key = _keyOf(t);
    final checked = _selected.contains(key);
    final muted = TextStyle(color: AppColors.textMuted, fontSize: 12);
    Widget cell(_Column c) => switch (c.sort) {
      BoardTableSort.status => Row(
        children: [
          BoardStatusDot(t),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              boardColumnLabel(t.column, l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: boardColumnColor(t.column), fontSize: 12),
            ),
          ),
        ],
      ),
      BoardTableSort.title => Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          t.thread?.localizedTitle(l10n) ?? t.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: t.archived ? AppColors.textMuted : AppColors.text,
            fontSize: 13,
            fontWeight: t.status == ThreadStatus.unread
                ? FontWeight.w600
                : FontWeight.normal,
          ),
        ),
      ),
      BoardTableSort.project => Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: BoardProjectChip(project: t.project, company: t.company),
        ),
      ),
      BoardTableSort.company => switch (t.company) {
        final company? => _CompanyCell(company),
        null => Text('—', style: TextStyle(color: AppColors.textFaint)),
      },
      BoardTableSort.kernel => Align(
        alignment: Alignment.centerLeft,
        child: BoardKernelBadge(t.kernel),
      ),
      BoardTableSort.diff => switch (t.diff) {
        final diff? => BoardDiff(diff),
        null => Text('—', style: TextStyle(color: AppColors.textFaint)),
      },
      BoardTableSort.updated => Text(
        relativeTime(t.updatedAt, DateTime.now(), l10n),
        maxLines: 1,
        style: muted,
      ),
      BoardTableSort.pinned =>
        t.pinned
            ? Icon(Icons.push_pin, size: 13, color: AppColors.textMuted)
            : const SizedBox.shrink(),
    };
    return SidebarMenu(
      items: () => boardThreadItems(t, widget.actions, l10n),
      builder: (context, menu) => HoverBuilder(
        cursor: SystemMouseCursors.click,
        builder: (context, hovered) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _tap(rows, t),
          onSecondaryTapUp: (details) => menu.open(details.globalPosition),
          child: Container(
            padding: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: checked
                  ? AppColors.accent.withValues(alpha: hovered ? 0.18 : 0.12)
                  : hovered
                  ? AppColors.hover
                  : null,
              border: last
                  ? null
                  : Border(
                      bottom: BorderSide(
                        color: AppColors.partBorder.withValues(alpha: 0.6),
                      ),
                    ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Opacity(
                      opacity: checked || hovered || _selected.isNotEmpty
                          ? 1
                          : 0,
                      child: _Checkbox(
                        checked: checked,
                        onTap: () => _select(
                          rows,
                          t,
                          range: HardwareKeyboard.instance.isShiftPressed,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: _cells(columns, cell)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A column's header: its label, and its arrow while the table sorts by
/// it ([sorted] true: ascending).
class _HeaderCell extends StatelessWidget {
  const _HeaderCell({
    required this.label,
    required this.sorted,
    required this.onTap,
    this.icon,
    this.tooltip,
  });

  final String label;
  final bool? sorted;
  final VoidCallback onTap;
  final IconData? icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final color = sorted != null ? AppColors.text : AppColors.textMuted;
    final child = HoverBuilder(
      cursor: SystemMouseCursors.click,
      builder: (context, hovered) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, size: 12, color: hovered ? AppColors.text : color)
            else
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: hovered ? AppColors.text : color,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (sorted case final ascending?)
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Icon(
                  ascending ? Codicons.arrowSmallUp : Codicons.arrowSmallDown,
                  size: 14,
                  color: AppColors.text,
                ),
              ),
          ],
        ),
      ),
    );
    return tooltip == null ? child : Tooltip(message: tooltip, child: child);
  }
}

/// A company's name by its icon, in its color.
class _CompanyCell extends StatelessWidget {
  const _CompanyCell(this.company);

  final Company company;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      companyIconOf(company, size: 12),
      const SizedBox(width: 6),
      Flexible(
        child: Text(
          company.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: switch (company.color) {
              final color? => Color(color),
              null => AppColors.textMuted,
            },
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

/// A 14px checkbox, as the dialogs' ([checked] null: some of them).
class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.checked, required this.onTap, this.tooltip});

  final bool? checked;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final colors = themeColors;
    final on = checked ?? true;
    final box = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: on ? AppColors.accent : colors['checkbox.background'],
            border: Border.all(
              color: on ? AppColors.accent : colors['checkbox.border'],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: on
              ? Icon(
                  checked == null ? Codicons.dash : Codicons.check,
                  size: 13,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
    return Semantics(
      checked: checked ?? false,
      label: tooltip,
      child: tooltip == null ? box : Tooltip(message: tooltip, child: box),
    );
  }
}

/// What to do to the rows [selected]: activate, pin or archive them all
/// (or undo it, when all of them are so).
class _BulkBar extends StatelessWidget {
  const _BulkBar({
    required this.selected,
    required this.actions,
    required this.onClear,
  });

  final List<BoardThread> selected;
  final BoardActions actions;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final active = selected.every((t) => t.active);
    final unarchived = [
      for (final t in selected)
        if (!t.archived) t,
    ];
    final pinned = unarchived.isNotEmpty && unarchived.every((t) => t.pinned);
    final archived = unarchived.isEmpty;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Text(
            l10n.boardTableSelected(selected.length),
            style: TextStyle(
              color: AppColors.text,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          _BulkButton(
            icon: Icons.bolt_outlined,
            label: active ? l10n.sidebarDeactivate : l10n.sidebarActivate,
            onTap: () => actions.setActive(selected, !active),
          ),
          if (unarchived.isNotEmpty)
            _BulkButton(
              icon: pinned ? Icons.push_pin : Icons.push_pin_outlined,
              label: pinned ? l10n.sidebarUnpin : l10n.sidebarPin,
              onTap: () => actions.pin(unarchived, !pinned),
            ),
          _BulkButton(
            icon: Icons.inventory_2_outlined,
            label: archived ? l10n.sidebarUnarchive : l10n.sidebarArchive,
            onTap: () => actions.archive(selected, !archived),
          ),
          const Spacer(),
          _BulkButton(
            icon: Codicons.close,
            label: l10n.boardTableClearSelection,
            onTap: onClear,
          ),
        ],
      ),
    );
  }
}

class _BulkButton extends StatelessWidget {
  const _BulkButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => HoverBuilder(
    cursor: SystemMouseCursors.click,
    builder: (context, hovered) => GestureDetector(
      onTap: onTap,
      child: Container(
        height: 26,
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: hovered ? AppColors.hover : null,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.textMuted),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: AppColors.text, fontSize: 12)),
          ],
        ),
      ),
    ),
  );
}
