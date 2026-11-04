import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../chat/widgets/inline_rename_field.dart';
import '../ide/ide_hover.dart' show IdeHoverBox;
import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show SidebarIconButton;
import '../sidebar/sidebar_menu.dart';
import '../theme/app_theme.dart';
import '../theme/codicons.dart';
import '../workspace/companies.dart';
import '../workspace/islands.dart';
import '../workspace/title_bar_double_click.dart';
import '../workspace/workspace.dart';
import 'office_model.dart';
import 'office_painter.dart';
import 'office_sprites.dart';

/// The office, in place of the conversations as the stashes are: each
/// company a building, each project with conversations in the Ativas a
/// room, each of those a character. A building clicked fills it (level
/// 2), a room clicked there fills it (level 3); Esc or "‹" goes back up.
class OfficeView extends StatefulWidget {
  const OfficeView({
    super.key,
    required this.workspace,
    required this.onOpenAgent,
    required this.onClose,
    this.leading,
    this.titleBarInset = 12,
    this.island,
  });

  final Workspace workspace;

  /// A character was clicked: its conversation opens.
  final ValueChanged<AgentThread> onOpenAgent;
  final VoidCallback onClose;

  /// The title bar's first widget, right of [titleBarInset]: the sidebar's
  /// toggle while it is hidden.
  final Widget? leading;
  final double titleBarInset;

  /// The card it is on, if any.
  final Color? island;

  @override
  State<OfficeView> createState() => OfficeViewState();
}

class OfficeViewState extends State<OfficeView> {
  OfficeSprites? _sprites;
  final FocusNode _focus = FocusNode(debugLabel: 'office');

  /// The building in view (by name, as the campus is built anew each
  /// time), and its room: null for the level above.
  String? _building;
  Project? _room;

  /// The character under the pointer, and where the pointer is.
  OfficeAgent? _hovered;
  Offset _hoverAt = Offset.zero;

  /// The character right clicked, its menu open; the one being renamed.
  AgentThread? _menuFor;
  AgentThread? _renaming;

  /// Level 2 or 3 is shown.
  bool get zoomed => _building != null;

  @override
  void initState() {
    super.initState();
    OfficeSprites.load().then(
      (sprites) {
        if (mounted) setState(() => _sprites = sprites);
      },
      onError: (Object _) {
        // Unreadable: boxes stand in for the characters.
      },
    );
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  /// One level up: from the room to its building, from there the campus.
  void up() => setState(() {
    if (_room != null) {
      _room = null;
    } else {
      _building = null;
    }
    _hovered = null;
    _renaming = null;
  });

  void _go(String? building, [Project? room]) => setState(() {
    _building = building;
    _room = room;
    _hovered = null;
    _renaming = null;
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListenableBuilder(
      listenable: Listenable.merge([widget.workspace, Companies.instance]),
      builder: (context, _) {
        final campus = campusOf(
          widget.workspace,
          Companies.instance,
          noCompany: l10n.officeNoCompany,
        );
        // Gone (hidden, emptied) since: the level above it.
        final building = campus.buildings
            .where((b) => b.name == _building)
            .firstOrNull;
        final room = building == null
            ? null
            : [
                ...building.rooms,
                for (final project in building.dim)
                  OfficeRoom(project, const []),
              ].where((r) => r.project == _room).firstOrNull;
        final body = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: campus.buildings.isEmpty
                  ? Center(
                      child: Text(
                        l10n.officeEmpty,
                        style: TextStyle(color: AppColors.textMuted),
                      ),
                    )
                  : _buildLevel(campus, building, room),
            ),
            _buildReception(campus),
          ],
        );
        return Focus(
          focusNode: _focus,
          autofocus: true,
          onKeyEvent: (node, event) {
            if (event is! KeyDownEvent ||
                event.logicalKey != LogicalKeyboardKey.escape ||
                !zoomed) {
              return KeyEventResult.ignored;
            }
            up();
            return KeyEventResult.handled;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitleBar(building, room),
              Expanded(
                child: switch (widget.island) {
                  final color? => Island(color: color, child: body),
                  null => body,
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// The level in view, zooming in from the one above as it changes.
  Widget _buildLevel(
    OfficeCampus campus,
    OfficeBuilding? building,
    OfficeRoom? room,
  ) {
    final geometry = switch ((building, room)) {
      (final building?, final room?) => CampusGeometry.room(building, room),
      (final building?, null) => CampusGeometry.building(building),
      _ => CampusGeometry.of(campus),
    };
    final level = _buildCanvas(geometry);
    return AnimatedSwitcher(
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 180),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween(begin: 0.92, end: 1.0).animate(animation),
          child: child,
        ),
      ),
      child: KeyedSubtree(
        key: ValueKey((building?.name, room?.project)),
        child: room == null
            ? level
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: level),
                  _buildConversations(room.project),
                ],
              ),
      ),
    );
  }

  /// [geometry] at the largest whole scale that fits (pixel art stays
  /// crisp), scrolled where even 1 does not.
  Widget _buildCanvas(CampusGeometry geometry) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = geometry.size;
        var scale = zoomed ? 8 : 4;
        while (scale > 1 &&
            (size.width * scale > constraints.maxWidth ||
                size.height * scale > constraints.maxHeight)) {
          scale--;
        }
        Offset at(Offset local) => local / scale.toDouble();
        final renamed = switch (_renaming) {
          final thread? => geometry.find((agent, _) => agent.thread == thread),
          null => null,
        };
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: SidebarMenu(
                items: _agentItems,
                builder: (context, menu) => MouseRegion(
                  // Short of level 3, anywhere is a way in.
                  cursor: _hovered != null || _room == null
                      ? SystemMouseCursors.click
                      : MouseCursor.defer,
                  onHover: (event) {
                    final agent = geometry.agentAt(at(event.localPosition));
                    if (agent == null && _hovered == null) return;
                    setState(() {
                      _hovered = agent;
                      _hoverAt = event.localPosition;
                    });
                  },
                  onExit: (_) => setState(() => _hovered = null),
                  child: GestureDetector(
                    onTapUp: (details) =>
                        _tap(geometry, at(details.localPosition)),
                    onSecondaryTapUp: (details) {
                      final thread = geometry
                          .agentAt(at(details.localPosition))
                          ?.thread;
                      if (thread == null) return;
                      setState(() => _menuFor = thread);
                      menu.open(details.globalPosition);
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomPaint(
                          size: size * scale.toDouble(),
                          painter: CampusPainter(
                            geometry: geometry,
                            scale: scale,
                            sprites: _sprites,
                            colors: (
                              text: AppColors.text,
                              muted: AppColors.textMuted,
                              border: AppColors.partBorder,
                              room: AppColors.hover,
                              building: AppColors.surface,
                              waiting: AppColors.caution,
                            ),
                          ),
                        ),
                        if (_hovered case final agent? when renamed == null)
                          Positioned(
                            left: _hoverAt.dx + 12,
                            top: _hoverAt.dy + 12,
                            child: IgnorePointer(child: _buildHover(agent)),
                          ),
                        if (renamed case (final agent, final rect))
                          Positioned(
                            left: rect.center.dx * scale - 100,
                            top: rect.top * scale,
                            width: 200,
                            child: InlineRenameField(
                              initial: agent.title,
                              onDone: (title) {
                                if (title != null && agent.thread != null) {
                                  widget.workspace.rename(agent.thread!, title);
                                }
                                setState(() => _renaming = null);
                                _focus.requestFocus();
                              },
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
      },
    );
  }

  /// A character opens its conversation; elsewhere a click zooms in: to
  /// the building from the campus, to the room from the building.
  void _tap(CampusGeometry geometry, Offset at) {
    _focus.requestFocus();
    if (geometry.agentAt(at)?.thread case final thread?) {
      widget.onOpenAgent(thread);
      return;
    }
    if (!zoomed) {
      if (geometry.buildingAt(at) case final box?) _go(box.building.name);
    } else if (_room == null) {
      if (geometry.roomAt(at) case final box?) {
        _go(_building, box.room.project);
      }
    }
  }

  /// The right clicked character's: as the sidebar's row has them.
  List<SidebarMenuItem> _agentItems() {
    final thread = _menuFor;
    if (thread == null) return const [];
    final l10n = context.l10n;
    return [
      SidebarMenuItem(
        thread.active ? l10n.sidebarDeactivate : l10n.sidebarActivate,
        icon: Icons.bolt_outlined,
        onSelected: () => widget.workspace.setActive([thread], !thread.active),
      ),
      SidebarMenuItem(
        l10n.sidebarArchive,
        icon: Icons.inventory_2_outlined,
        onSelected: () => widget.workspace.setArchived(thread, true),
      ),
      SidebarMenuItem(
        l10n.commonRename,
        icon: Icons.edit_outlined,
        onSelected: () => setState(() => _renaming = thread),
      ),
    ];
  }

  Widget _buildHover(OfficeAgent agent) {
    final l10n = context.l10n;
    final status = switch (agent.status) {
      ThreadStatus.needsInput => l10n.sidebarNeedsInput,
      ThreadStatus.running => l10n.sidebarRunning,
      ThreadStatus.unread => l10n.sidebarUnread,
      ThreadStatus.idle => null,
    };
    return IdeHoverBox(
      maxWidth: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(agent.title, style: TextStyle(color: AppColors.text)),
          if (status != null)
            Text(status, style: TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }

  /// Level 3's side: all the project's conversations, the inactive too.
  Widget _buildConversations(Project project) {
    final workspace = widget.workspace;
    final threads = [
      for (final thread in workspace.threads)
        if (thread.project == project &&
            !thread.archived &&
            !thread.untouched &&
            workspace.listsInSidebar(thread))
          thread,
    ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.partBorder)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 6),
        children: [
          for (final thread in threads)
            InkWell(
              onTap: () => widget.onOpenAgent(thread),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  '${thread.shownStatus == ThreadStatus.needsInput ? '❗ ' : ''}'
                  '${thread.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                        thread.active || thread.shownStatus != ThreadStatus.idle
                        ? AppColors.text
                        : AppColors.textMuted,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// The counts; a click goes to the next waiting on the user (or
  /// finished unseen), as the command does.
  Widget _buildReception(OfficeCampus campus) {
    final next = nextNeedingYou(
      [for (final agent in campus.agents) ?agent.thread],
      widget.workspace.current,
      (thread) => thread.shownStatus,
    );
    return MouseRegion(
      cursor: next == null ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: next == null ? null : () => widget.onOpenAgent(next),
        child: Container(
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.partBorder)),
          ),
          child: Text(
            context.l10n.officeReception(
              campus.working,
              campus.waiting,
              campus.done,
            ),
            style: TextStyle(
              color: campus.waiting > 0
                  ? AppColors.caution
                  : AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  /// "‹" and where it is: Escritório › building › room, each a way back.
  Widget _buildTitleBar(OfficeBuilding? building, OfficeRoom? room) {
    final l10n = context.l10n;
    Widget crumb(String text, VoidCallback? onTap) {
      final label = Text(
        text,
        style: TextStyle(
          color: onTap == null ? AppColors.text : AppColors.textMuted,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
      );
      if (onTap == null) return label;
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: onTap, child: label),
      );
    }

    final separator = Text(
      ' › ',
      style: TextStyle(color: AppColors.textFaint, fontSize: 12.5),
    );
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
            if (building != null) ...[
              SidebarIconButton(
                icon: Codicons.chevronLeft,
                tooltip: l10n.officeBack,
                onTap: up,
              ),
              const SizedBox(width: 4),
            ],
            crumb(l10n.officeTitle, building == null ? null : () => _go(null)),
            if (building != null) ...[
              separator,
              crumb(
                building.name,
                room == null ? null : () => _go(building.name),
              ),
            ],
            if (room != null) ...[
              separator,
              Flexible(child: crumb(room.project.name, null)),
            ],
            const Spacer(),
            SidebarIconButton(
              icon: Codicons.close,
              tooltip: l10n.officeClose,
              onTap: widget.onClose,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
