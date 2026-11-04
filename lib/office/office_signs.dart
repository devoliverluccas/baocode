import 'dart:async';

import 'package:flutter/material.dart';

import '../icons/project_icon_view.dart';
import '../ide/ide_menu.dart';
import '../l10n/l10n.dart';
import '../theme/app_theme.dart';
import '../workspace/company_dialog.dart' show assignMenu;
import '../workspace/workspace.dart';
import 'office_painter.dart';
import 'office_scoreboard.dart';
import 'office_theme.dart';

/// What the canvas cannot paint, laid over it where [geometry] puts it at
/// [unit] logical pixels a sprite's pixel: each room's project icon, and
/// on the building of no company the way to put its projects in one.
class CampusSigns extends StatelessWidget {
  const CampusSigns({
    super.key,
    required this.geometry,
    required this.unit,
    required this.workspace,
    this.scores = const {},
  });

  final CampusGeometry geometry;
  final double unit;
  final Workspace workspace;

  /// Each building's day so far, by its company's name ('' for none's):
  /// over its roof.
  final Map<String, OfficeScore> scores;

  /// A room's project icon, at its largest, in logical pixels: on its
  /// door's plaque ([OfficeTheme.plaque]).
  static const iconSide = 14.0;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      for (final building in geometry.buildings) ...[
        if (scores[building.building.company?.name ?? ''] case final score?)
          Positioned(
            left: building.sign.left * unit,
            width: building.sign.width * unit,
            top: (building.sign.top - CampusGeometry.gap) * unit,
            height: CampusGeometry.gap * unit,
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  score.label(context.l10n),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ),
        // Each room's project icon on its door's plaque (see RoomScene.paint),
        // else its initial.
        for (final room in building.rooms)
          if (!room.card)
            if (OfficeTheme.plaque(room.rect.topLeft) case final plaque)
              Positioned(
                left: plaque.left * unit,
                top: plaque.top * unit,
                width: plaque.width * unit,
                height: plaque.height * unit,
                child: IgnorePointer(
                  child: Center(
                    child: switch (workspace.iconOf(room.room.project)) {
                      final icon? => ProjectIconView(
                        icon: icon,
                        library: workspace.icons,
                        size: (plaque.height * unit - 3).clamp(8, iconSide),
                      ),
                      null => Text(
                        room.room.project.name.characters.first.toUpperCase(),
                        style: TextStyle(
                          color: CampusPainter.inkOn(
                            switch (building.building.company) {
                              final company? => Color(
                                company.color ?? 0xff8e8e93,
                              ),
                              null => const Color(0xffc9a227),
                            },
                          ),
                          fontSize: (plaque.height * unit - 4).clamp(7, 12),
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    },
                  ),
                ),
              ),
        if (building.building.company == null)
          Positioned(
            right: (geometry.size.width - building.sign.right + 3) * unit,
            top: building.sign.top * unit,
            height: building.sign.height * unit,
            child: _Assign(
              projects: [
                for (final room in building.building.rooms) room.project,
                ...building.building.dim,
              ],
              size: 11.5,
            ),
          ),
      ],
    ],
  );
}

/// "atribuir": a menu putting one of [projects] in a company.
class _Assign extends StatelessWidget {
  const _Assign({required this.projects, required this.size});

  final List<Project> projects;
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // On the grey of its sign (see CampusPainter.colorOf).
    final ink = CampusPainter.inkOn(AppColors.textMuted);
    return Tooltip(
      message: l10n.officeAssignTooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            final box = context.findRenderObject()! as RenderBox;
            unawaited(
              showIdeMenu(
                context,
                anchor: box.localToGlobal(Offset.zero) & box.size,
                // One project: its companies at once.
                entries: projects.length == 1
                    ? assignMenu(context, projects.single.path)
                    : [
                        for (final project in projects)
                          IdeMenuAction(
                            project.name,
                            submenu: assignMenu(context, project.path),
                          ),
                      ],
              ),
            );
          },
          child: Center(
            child: Text(
              l10n.officeAssign,
              style: TextStyle(
                color: ink,
                fontSize: size,
                decoration: TextDecoration.underline,
                decorationColor: ink,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
