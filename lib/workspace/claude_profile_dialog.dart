import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../kernel/claude_code/claude_environment.dart';
import '../l10n/l10n.dart';

/// Asks which Claude Code profile (`~/.claude-promov`, `~/.claude-stark`, …)
/// the sessions in [path] run with, and keeps the answer. Asked only when
/// none was picked yet, unless [change]; with one profile there is nothing
/// to ask. False when the user cancelled.
Future<bool> pickClaudeProfile(
  BuildContext context,
  String path, {
  bool change = false,
}) async {
  if (!change && ClaudeEnvironment.profileFor(path) != null) return true;
  final profiles = ClaudeEnvironment.availableProfiles();
  if (profiles.length < 2) return true;
  final current = ClaudeEnvironment.profileFor(path);
  final picked = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(context.l10n.claudeProfileTitle(p.basename(path))),
      children: [
        for (final profile in profiles)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, profile),
            child: Row(
              children: [
                Icon(
                  profile == current
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(p.basename(profile).substring(1)),
              ],
            ),
          ),
      ],
    ),
  );
  if (picked == null) return false;
  ClaudeEnvironment.setProfile(path, picked);
  return true;
}
