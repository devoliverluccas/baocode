import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../base/step_clock.dart';
import '../chat/widgets/inline_rename_field.dart';
import '../ide/ide_hover.dart' show IdeHoverBox;
import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show SidebarIconButton;
import '../sidebar/sidebar_menu.dart';
import '../theme/app_theme.dart';
import '../theme/codicons.dart';
import '../theme/workbench_theme.dart' show themeColors;
import '../usage/usage_ledger.dart';
import '../usage/usage_record.dart';
import '../workspace/companies.dart';
import '../workspace/islands.dart';
import '../workspace/title_bar_double_click.dart';
import '../workspace/workspace.dart';
import 'office_characters.dart';
import 'office_model.dart';
import 'office_painter.dart';
import 'office_scoreboard.dart';
import 'office_signs.dart';
import 'office_sprites.dart';

/// The office, in place of the conversations as the stashes are: each
/// company a building, each project with conversations in the Ativas a
/// room, each of those a character. A building clicked fills it (level
/// 2), a room clicked there or on the campus fills it (level 3); Esc,
/// Backspace or "‹ Voltar" goes back up.
class OfficeView extends StatefulWidget {
  const OfficeView({
    super.key,
    required this.workspace,
    required this.onOpenAgent,
    required this.onClose,
    this.leading,
    this.titleBarInset = 12,
    this.island,
    this.scenes,
    this.room,
  });

  /// The room to open at (level 3), if it has one: the mini office's.
  final Project? room;

  final Workspace workspace;

  /// The characters, kept while it is closed (the workbench's): opened
  /// again, who was in is where it was. Null: its own, anew each time.
  final OfficeScenes? scenes;

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
  late Project? _room = widget.room;

  /// The character under the pointer, and where the pointer is.
  OfficeAgent? _hovered;
  Offset _hoverAt = Offset.zero;

  /// The building or room under the pointer a click would go into, in the
  /// sprites' pixels.
  Rect? _target;

  /// The character right clicked, its menu open; the one being renamed,
  /// where it was then (in the sprites' pixels).
  AgentThread? _menuFor;
  Rect _menuAt = Rect.zero;
  (AgentThread, Rect)? _renaming;

  /// Level 2 or 3 is shown.
  bool get zoomed => _building != null;

  /// The rooms' characters, on [_clock]: at its quickest while one walks,
  /// slower while all sit or stand at their work. Stopped, all still, where
  /// motion is turned down.
  late final _scenes = (widget.scenes ?? OfficeScenes())..resume();
  late final _clock = StepClock(_slow)..addListener(_tick);
  static const _slow = Duration(milliseconds: 150);
  Duration _ticked = Duration.zero;
  bool _still = false;

  /// Each building's day so far, on its roof.
  late final _scores = OfficeScores(
    UsageLedger.current,
    _buildingOf,
    also: Companies.instance,
  );

  /// The company of [call]'s conversation's project ('' for none); null
  /// for a project not the sidebar's.
  String? _buildingOf(UsageCall call) {
    final workspace = widget.workspace;
    final project =
        workspace.threads
            .where(
              (thread) => call.session != null && thread.id == call.session,
            )
            .firstOrNull
            ?.project ??
        workspace.sidebarProjectsHere
            .where((project) => project.name == call.project)
            .firstOrNull;
    if (project == null) return null;
    return Companies.instance.of(project.path)?.name ?? '';
  }

  void _tick() {
    final now = _clock.time;
    // A late or first tick: no leap across the room.
    final seconds = (now - _ticked).inMicroseconds / 1e6;
    _ticked = now;
    _scenes.update(seconds.clamp(0, 0.25));
    _clock.step = _scenes.moving ? StepClock.frame : _slow;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _still = _clock.keepTo(context);
    _ticked = _clock.time;
  }

  @override
  void initState() {
    super.initState();
    // Esc and Backspace work from the start, nothing clicked yet.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
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
    _scores.dispose();
    _clock.dispose();
    _focus.dispose();
    super.dispose();
  }

  /// One level up: from the room to its building, from there the campus.
  void up() => setState(() {
    _fit();
    if (_room != null) {
      _room = null;
    } else {
      _building = null;
    }
    _hovered = null;
    _target = null;
    _renaming = null;
  });

  void _go(String? building, [Project? room]) => setState(() {
    _fit();
    _building = building;
    _room = room;
    _hovered = null;
    _target = null;
    _renaming = null;
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.workspace,
        Companies.instance,
        _scores,
      ]),
      builder: (context, _) {
        final campus = campusOf(
          widget.workspace,
          Companies.instance,
          noCompany: l10n.officeNoCompany,
        );
        // Opened at a room: its building's, if it is in one.
        if (_building == null && _room != null) {
          _building = campus.buildings
              .where((b) => roomsOf(b).any((r) => r.project == _room))
              .firstOrNull
              ?.name;
          if (_building == null) _room = null;
        }
        // Gone (hidden, emptied) since: the level above it.
        final building = campus.buildings
            .where((b) => b.name == _building)
            .firstOrNull;
        final room = building == null
            ? null
            : roomsOf(building).where((r) => r.project == _room).firstOrNull;
        _scenes.sync(campus, still: _still);
        // Nobody in a room: no frames to draw till someone comes.
        if (_scenes.isEmpty) {
          _clock.stop();
        } else {
          _clock.keepTo(context);
        }
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
                !zoomed ||
                // Backspace is the rename field's own.
                _renaming != null ||
                (event.logicalKey != LogicalKeyboardKey.escape &&
                    event.logicalKey != LogicalKeyboardKey.backspace)) {
              return KeyEventResult.ignored;
            }
            up();
            return KeyEventResult.handled;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitleBar(campus, building, room),
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
    final counts = {
      for (final project in building?.dim ?? const <Project>[])
        project: _threadsOf(project).length,
    };
    final level = switch ((building, room)) {
      (final building?, final room?) => _buildCanvas<int>(
        (_, _) => CampusGeometry.room(building, room),
        const [0],
        max: 8,
      ),
      (final building?, null) => _buildCanvas<(int, int)>(
        (option, unit) => CampusGeometry.building(
          building,
          columns: option.$1,
          cardColumns: option.$2,
          unit: unit,
          counts: counts,
        ),
        buildingColumns(building),
        max: 8,
      ),
      _ => _buildCanvas<(int, int)>(
        (option, _) =>
            CampusGeometry.of(campus, columns: option.$1, perRow: option.$2),
        campusOptions(campus.buildings.length),
        max: 5,
      ),
    };
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

  /// The user's zoom, in whole steps of the screen's pixels over the
  /// scale that fits, and the canvas's offset in the view: what the wheel
  /// and a drag change, a double click (or another level) puts back.
  int _zoom = 0;
  Offset _pan = Offset.zero;
  DateTime? _tapped;

  void _fit() {
    _zoom = 0;
    _pan = Offset.zero;
  }

  /// [pan] kept so the canvas of [content] does not leave [space]: within
  /// it where it is smaller, covering it where larger.
  static Offset _clamp(Offset pan, Size content, Size space) {
    double axis(double at, double content, double space) {
      final room = space - content;
      return at.clamp(math.min(0.0, room), math.max(0.0, room));
    }

    return Offset(
      axis(pan.dx, content.width, space.width),
      axis(pan.dy, content.height, space.height),
    );
  }

  /// The level [make] lays out, with the one of [options] that fits the
  /// view at the largest whole scale of the screen's pixels ([fitGeometry]),
  /// from the top left; then zoomed by the wheel (about the pointer) and
  /// moved by a drag.
  Widget _buildCanvas<T>(
    CampusGeometry Function(T option, double unit) make,
    List<T> options, {
    required int max,
  }) {
    final ratio = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final space = constraints.biggest;
        final fit = fitGeometry(
          make,
          options,
          space,
          max: (max * ratio).floor(),
          pixelRatio: ratio,
        );
        // Down to 1, up to 4 times the fit's.
        final most = math.max(fit.scale * 4, 8);
        final scale = (fit.scale + _zoom).clamp(1, most);
        final unit = scale / ratio;
        final geometry = scale == fit.scale
            ? fit.geometry
            : make(fit.option, unit);
        final size = geometry.size;
        final pan = _clamp(_pan, size * unit, space);
        // Of the view to the canvas, in the sprites' pixels.
        Offset at(Offset local) => (local - pan) / unit;
        void zoomBy(int steps, Offset about) {
          final next = (scale + steps).clamp(1, most);
          if (next == scale) return;
          final to = next / ratio;
          final content = make(fit.option, to).size * to;
          setState(() {
            _zoom = next - fit.scale;
            _pan = _clamp(about - (about - pan) * (to / unit), content, space);
          });
        }

        return SidebarMenu(
          items: _agentItems,
          builder: (context, menu) => Listener(
            onPointerSignal: (event) {
              if (event is! PointerScrollEvent) return;
              GestureBinding.instance.pointerSignalResolver.register(
                event,
                (event) => zoomBy(
                  (event as PointerScrollEvent).scrollDelta.dy < 0 ? 1 : -1,
                  event.localPosition,
                ),
              );
            },
            child: MouseRegion(
              cursor: _hovered != null || _target != null
                  ? SystemMouseCursors.click
                  : MouseCursor.defer,
              onHover: (event) {
                final local = at(event.localPosition);
                final agent = _hit(geometry, local)?.$1;
                final target = agent == null
                    ? _targetAt(geometry, local)
                    : null;
                if (agent == null && _hovered == null && target == _target) {
                  return;
                }
                setState(() {
                  _hovered = agent;
                  _hoverAt = event.localPosition;
                  _target = target;
                });
              },
              onExit: (_) => setState(() {
                _hovered = null;
                _target = null;
              }),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) => _tap(geometry, at(details.localPosition)),
                onSecondaryTapUp: (details) {
                  final hit = _hit(geometry, at(details.localPosition));
                  final thread = hit?.$1.thread;
                  if (thread == null) return;
                  setState(() {
                    _menuFor = thread;
                    _menuAt = hit!.$2;
                  });
                  menu.open(details.globalPosition);
                },
                onPanUpdate: (details) => setState(
                  () => _pan = _clamp(pan + details.delta, size * unit, space),
                ),
                child: ClipRect(
                  child: Stack(
                    children: [
                      Positioned(
                        left: pan.dx,
                        top: pan.dy,
                        width: size.width * unit,
                        height: size.height * unit,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CustomPaint(
                              size: size * unit,
                              painter: CampusPainter(
                                geometry: geometry,
                                scale: scale,
                                pixelRatio: ratio,
                                sprites: _sprites,
                                scenes: _scenes,
                                l10n: context.l10n,
                                repaint: _clock,
                                colors: officeColors(),
                                font: DefaultTextStyle.of(context).style,
                                highlight: _target,
                              ),
                            ),
                            Positioned.fill(
                              child: CampusSigns(
                                geometry: geometry,
                                unit: unit,
                                workspace: widget.workspace,
                                scores: _scores.value,
                              ),
                            ),
                            if (_renaming case (final thread, final rect))
                              Positioned(
                                left: rect.center.dx * unit - 100,
                                top: rect.top * unit,
                                width: 200,
                                child: InlineRenameField(
                                  initial: thread.title,
                                  onDone: (title) {
                                    if (title != null) {
                                      widget.workspace.rename(thread, title);
                                    }
                                    setState(() => _renaming = null);
                                    _focus.requestFocus();
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (_hovered case final agent? when _renaming == null)
                        Positioned(
                          left: _hoverAt.dx + 12,
                          top: _hoverAt.dy + 12,
                          child: IgnorePointer(child: _buildHover(agent)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// The character at [at] and where it is: where it walks once the
  /// sprites are drawn, in its row before.
  (OfficeAgent, Rect)? _hit(CampusGeometry geometry, Offset at) =>
      _sprites == null
      ? geometry.find((_, rect) => rect.contains(at))
      : _scenes.find(geometry, at);

  /// A character opens its conversation; elsewhere a click zooms in: to
  /// a room (from the campus or its building), else to the building.
  void _tap(CampusGeometry geometry, Offset at) {
    _focus.requestFocus();
    final now = DateTime.now();
    final twice =
        _tapped != null && now.difference(_tapped!) < kDoubleTapTimeout;
    _tapped = now;
    if (_hit(geometry, at)?.$1.thread case final thread?) {
      widget.onOpenAgent(thread);
      return;
    }
    // A double click on nothing to go into: back as it fits.
    if (twice && _targetAt(geometry, at) == null) {
      setState(_fit);
      return;
    }
    if (_room != null) return;
    if (geometry.roomAt(at) case final box?) {
      final building = geometry.buildings.firstWhere(
        (b) => b.rooms.contains(box),
      );
      _go(building.building.name, box.room.project);
    } else if (!zoomed) {
      if (geometry.buildingAt(at) case final box?) _go(box.building.name);
    }
  }

  /// What a click at [at] would go into: a room, else (on the campus) a
  /// building; nothing at level 3.
  Rect? _targetAt(CampusGeometry geometry, Offset at) {
    if (_room != null) return null;
    return geometry.roomAt(at)?.rect ??
        (zoomed ? null : geometry.buildingAt(at)?.rect);
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
        onSelected: () => setState(() => _renaming = (thread, _menuAt)),
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
  /// [project]'s conversations the sidebar lists, the inactive too.
  List<AgentThread> _threadsOf(Project project) => [
    for (final thread in widget.workspace.threads)
      if (thread.project == project &&
          !thread.archived &&
          !thread.untouched &&
          widget.workspace.listsInSidebar(thread))
        thread,
  ];

  Widget _buildConversations(Project project) {
    final threads = _threadsOf(project)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
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
            // Nobody in: how to bring someone, in place of the counts.
            campus.agents.isEmpty
                ? context.l10n.officeNoAgents
                : context.l10n.officeReception(
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

  /// "‹ Voltar" and where it is: Escritório › Andar … › Sala …, each a
  /// way back; beside, the way to the room (or building) before and after.
  Widget _buildTitleBar(
    OfficeCampus campus,
    OfficeBuilding? building,
    OfficeRoom? room,
  ) {
    final l10n = context.l10n;
    Widget crumb(String text, VoidCallback? onTap) {
      final label = Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
    // At a room, its building's others; at a building, the other buildings.
    final rooms = building == null ? const <OfficeRoom>[] : roomsOf(building);
    final count = room != null ? rooms.length : campus.buildings.length;
    final at = room != null
        ? rooms.indexWhere((r) => r.project == room.project)
        : campus.buildings.indexWhere((b) => b.name == building?.name);
    void step(int by) {
      final next = (at + by) % count;
      if (room != null) {
        _go(_building, rooms[next].project);
      } else {
        _go(campus.buildings[next].name);
      }
    }

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
              Tooltip(
                message: l10n.officeBack,
                child: TextButton.icon(
                  onPressed: up,
                  icon: const Icon(Codicons.chevronLeft, size: 14),
                  label: Text(l10n.officeBackLabel),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.text,
                    textStyle: const TextStyle(fontSize: 12.5),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            crumb(l10n.officeTitle, building == null ? null : () => _go(null)),
            if (building != null) ...[
              separator,
              Flexible(
                child: crumb(
                  l10n.officeFloor(building.name),
                  room == null ? null : () => _go(building.name),
                ),
              ),
            ],
            if (room != null) ...[
              separator,
              Flexible(child: crumb(l10n.officeRoom(room.project.name), null)),
            ],
            if (building != null && count > 1 && at >= 0) ...[
              const SizedBox(width: 8),
              SidebarIconButton(
                icon: Codicons.chevronLeft,
                tooltip: room != null
                    ? l10n.officePrevRoom
                    : l10n.officePrevFloor,
                onTap: () => step(-1),
              ),
              SidebarIconButton(
                icon: Codicons.chevronRight,
                tooltip: room != null
                    ? l10n.officeNextRoom
                    : l10n.officeNextFloor,
                onTap: () => step(1),
              ),
            ],
            const Spacer(),
            SidebarIconButton(
              icon: widget.workspace.miniOffice
                  ? Codicons.layoutPanelOff
                  : Codicons.layoutPanelRight,
              tooltip: widget.workspace.miniOffice
                  ? l10n.officeMiniHide
                  : l10n.officeMiniShow,
              onTap: () =>
                  widget.workspace.miniOffice = !widget.workspace.miniOffice,
            ),
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

/// [building]'s rooms as level 2 has them: those with someone in, then
/// its other projects', empty.
List<OfficeRoom> roomsOf(OfficeBuilding building) => [
  ...building.rooms,
  for (final project in building.dim) OfficeRoom(project, const []),
];

/// The office's colors from the theme's: a night sky over dark ones, a day
/// one over light ones, the ground grass in both.
OfficeColors officeColors() {
  final dark = themeColors.dark;
  final under = AppColors.background;
  return (
    text: AppColors.text,
    muted: AppColors.textMuted,
    border: AppColors.partBorder,
    room: AppColors.hover,
    building: AppColors.surface,
    waiting: AppColors.caution,
    sky: Color.lerp(
      under,
      dark ? const Color(0xff0b1830) : const Color(0xffaed8f5),
      0.5,
    )!,
    ground: Color.lerp(
      under,
      dark ? const Color(0xff1f3a1c) : const Color(0xff8cc56b),
      0.6,
    )!,
    lit: Color.lerp(
      AppColors.hover,
      const Color(0xffffd54f),
      dark ? 0.35 : 0.45,
    )!,
  );
}
