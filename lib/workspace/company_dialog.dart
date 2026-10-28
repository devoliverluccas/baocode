import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../kernel/claude_code/claude_environment.dart';
import '../l10n/l10n.dart';
import 'companies.dart';

/// A profile as it is shown: its folder's name, `claude-promov`.
String profileLabel(String profile) => p.basename(profile).substring(1);

/// Asks which company [path] is in, a new one if need be, and puts it there
/// (to run with its Claude). Asked only when it is in none yet, unless
/// [change]. False when the user cancelled.
Future<bool> pickCompany(
  BuildContext context,
  String path, {
  bool change = false,
}) async {
  final companies = Companies.instance;
  final current = companies.of(path);
  if (!change && current != null) return true;
  final l10n = context.l10n;
  final picked = companies.list.isEmpty
      ? await editCompany(context)
      : await showDialog<String>(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text(l10n.companyPickTitle(p.basename(path))),
            children: [
              for (final company in companies.list)
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, company.name),
                  child: Row(
                    children: [
                      Icon(
                        company == current
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(company.name),
                      const SizedBox(width: 8),
                      Text(
                        profileLabel(company.profile),
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              const Divider(),
              SimpleDialogOption(
                onPressed: () async {
                  final name = await editCompany(context);
                  if (context.mounted) Navigator.pop(context, name);
                },
                child: Row(
                  children: [
                    const Icon(Icons.add, size: 16),
                    const SizedBox(width: 8),
                    Text(l10n.companyNew),
                  ],
                ),
              ),
            ],
          ),
        );
  if (picked == null) return false;
  companies.assign(path, picked);
  return true;
}

/// Asks a company's name and Claude, a new one's or [editing]'s, and keeps
/// them. Returns its name, or null when cancelled.
Future<String?> editCompany(BuildContext context, {Company? editing}) {
  final profiles = ClaudeEnvironment.availableProfiles();
  final name = TextEditingController(text: editing?.name);
  var profile = editing?.profile ?? profiles.firstOrNull ?? '';
  return showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        final l10n = context.l10n;
        void done() {
          final text = name.text.trim();
          if (text.isEmpty || profile.isEmpty) return;
          final companies = Companies.instance;
          if (editing != null && editing.name != text) {
            if (companies.byName(text) != null) return;
            companies.rename(editing.name, text);
          }
          companies.put(text, profile);
          Navigator.pop(context, text);
        }

        return AlertDialog(
          title: Text(editing == null ? l10n.companyNew : l10n.companyEdit),
          content: SizedBox(
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: name,
                  autofocus: true,
                  decoration: InputDecoration(labelText: l10n.companyName),
                  onSubmitted: (_) => done(),
                ),
                const SizedBox(height: 16),
                Text(l10n.companyClaude),
                for (final option in profiles)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      option == profile
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      size: 18,
                    ),
                    title: Text(profileLabel(option)),
                    onTap: () => setState(() => profile = option),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(onPressed: done, child: Text(l10n.commonOk)),
          ],
        );
      },
    ),
  );
}
