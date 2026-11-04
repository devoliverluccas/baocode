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

  /// A room sign's icon, in sprite pixels: as tall as its name's line.
  static const iconSide = 7.0;

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
        for (final room in building.rooms)
          if (workspace.iconOf(room.room.project) case final icon?)
            Positioned(
              // Left of the "❗" of someone waiting not shown.
              left:
                  (room.rect.right - iconSide - (room.room.waiting ? 11 : 2)) *
                  unit,
              top: (room.rect.top + 2) * unit,
              child: IgnorePointer(
                child: ProjectIconView(
                  icon: icon,
                  library: workspace.icons,
                  size: iconSide * unit,
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
              size: 6 * unit,
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
