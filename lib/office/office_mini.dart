import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../base/step_clock.dart';
import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show SidebarIconButton;
import '../theme/app_theme.dart';
import '../theme/codicons.dart';
import '../workspace/companies.dart';
import '../workspace/workspace.dart';
import 'office_characters.dart';
import 'office_model.dart';
import 'office_painter.dart';
import 'office_sprites.dart';
import 'office_view.dart' show officeColors;

/// The office small in the chat's corner: the room of [project] when it
/// has one in the Ativas, else the whole campus; the same [scenes] as the
/// office's, its bubbles their icon alone. A click opens the office, at
/// [project]'s room if it has one.
class MiniOffice extends StatefulWidget {
  const MiniOffice({
    super.key,
    required this.workspace,
    required this.scenes,
    required this.project,
    required this.onOpen,
  });

  final Workspace workspace;
  final OfficeScenes scenes;
  final Project? project;
  final VoidCallback onOpen;

  /// Its largest: the room or campus scaled down to fit, never up.
  static const size = Size(280, 240);

  @override
  State<MiniOffice> createState() => _MiniOfficeState();
}

class _MiniOfficeState extends State<MiniOffice> {
  OfficeSprites? _sprites;
  late final _clock = StepClock(_slow)..addListener(_tick);
  static const _slow = Duration(milliseconds: 150);
  Duration _ticked = Duration.zero;
  bool _still = false;

  void _tick() {
    final now = _clock.time;
    final seconds = (now - _ticked).inMicroseconds / 1e6;
    _ticked = now;
    widget.scenes.update(seconds.clamp(0, 0.25));
    _clock.step = widget.scenes.moving ? StepClock.frame : _slow;
  }

  @override
  void initState() {
    super.initState();
    widget.scenes.resume();
    OfficeSprites.load().then((sprites) {
      if (mounted) setState(() => _sprites = sprites);
    }, onError: (Object _) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _still = _clock.keepTo(context);
    _ticked = _clock.time;
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

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
        widget.scenes.sync(campus, still: _still);
        if (widget.scenes.isEmpty) {
          _clock.stop();
        } else {
          _clock.keepTo(context);
        }
        final ratio = MediaQuery.devicePixelRatioOf(context);
        final here = [
          for (final building in campus.buildings)
            for (final room in building.rooms)
              if (room.project == widget.project) (building, room),
        ].firstOrNull;
        final fit = fitGeometry<(int, int)>(
          (option, _) => switch (here) {
            (final building, final room) => CampusGeometry.room(building, room),
            null => CampusGeometry.of(
              campus,
              columns: option.$1,
              perRow: option.$2,
            ),
          },
          here == null
              ? campusOptions(campus.buildings.length)
              : const [(0, 0)],
          MiniOffice.size,
          max: (3 * ratio).floor(),
          pixelRatio: ratio,
        );
        final unit = fit.scale / ratio;
        final canvas = fit.geometry.size * unit;
        final shown =
            canvas *
            math.min(
              1.0,
              math.min(
                MiniOffice.size.width / canvas.width,
                MiniOffice.size.height / canvas.height,
              ),
            );
        return Tooltip(
          message: l10n.officeMiniOpen,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onOpen,
              child: Container(
                width: shown.width,
                height: shown.height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.conversationSurface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(color: Color(0x33000000), blurRadius: 8),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topLeft,
                        child: CustomPaint(
                          size: canvas,
                          painter: CampusPainter(
                            geometry: fit.geometry,
                            scale: fit.scale,
                            pixelRatio: ratio,
                            sprites: _sprites,
                            scenes: widget.scenes,
                            l10n: l10n,
                            repaint: _clock,
                            colors: officeColors(),
                            font: DefaultTextStyle.of(context).style,
                            iconsOnly: true,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: SidebarIconButton(
                        icon: Codicons.close,
                        size: 20,
                        tooltip: l10n.officeMiniHide,
                        onTap: () => widget.workspace.miniOffice = false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
