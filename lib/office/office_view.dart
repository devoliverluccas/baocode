import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../sidebar/sidebar.dart' show SidebarIconButton;
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
/// room, each of those a character.
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
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final body = ListenableBuilder(
      listenable: Listenable.merge([widget.workspace, Companies.instance]),
      builder: (context, _) {
        final campus = campusOf(
          widget.workspace,
          Companies.instance,
          noCompany: l10n.officeNoCompany,
        );
        return Column(
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
                  : _buildCampus(campus),
            ),
            _buildReception(campus),
          ],
        );
      },
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
  }

  /// Level 1: the buildings side by side, at the largest whole scale that
  /// fits (pixel art stays crisp), scrolled where even 1 does not.
  Widget _buildCampus(OfficeCampus campus) {
    final geometry = CampusGeometry.of(campus);
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = geometry.size;
        var scale = 4;
        while (scale > 1 &&
            (size.width * scale > constraints.maxWidth ||
                size.height * scale > constraints.maxHeight)) {
          scale--;
        }
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTapUp: (details) {
                  final agent = geometry.agentAt(
                    details.localPosition / scale.toDouble(),
                  );
                  if (agent?.thread case final thread?) {
                    widget.onOpenAgent(thread);
                  }
                },
                child: CustomPaint(
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReception(OfficeCampus campus) => Container(
    height: 28,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: AppColors.partBorder)),
    ),
    child: Text(
      context.l10n.officeReception(campus.working, campus.waiting, campus.done),
      style: TextStyle(color: AppColors.textMuted, fontSize: 12),
    ),
  );

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
              l10n.officeTitle,
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
            ),
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
