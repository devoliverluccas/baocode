import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../kernel/claude_code/claude_environment.dart';
import '../l10n/l10n.dart';
import '../theme/app_theme.dart';
import 'companies.dart';
import 'workspace.dart' show Project;

/// The colors a company's folder can have, as ARGB.
const companyColors = [
  0xFF4FC3F7,
  0xFF81C784,
  0xFFFFB74D,
  0xFFE57373,
  0xFFBA68C8,
  0xFFF06292,
  0xFFFFD54F,
  0xFF4DB6AC,
  0xFF90A4AE,
];

/// The icons a company can have, by the name it keeps.
const companyIcons = <String, IconData>{
  'folder': Icons.folder_rounded,
  'business': Icons.business_rounded,
  'work': Icons.work_rounded,
  'store': Icons.storefront_rounded,
  'rocket': Icons.rocket_launch_rounded,
  'moon': Icons.dark_mode_rounded,
  'star': Icons.star_rounded,
  'bolt': Icons.bolt_rounded,
  'code': Icons.code_rounded,
  'heart': Icons.favorite_rounded,
};

/// [company]'s icon in its color, as its header shows it.
Widget companyIconOf(Company company, {double size = 14}) => Icon(
  companyIcons[company.icon] ?? Icons.folder_rounded,
  size: size,
  color: switch (company.color) {
    final color? => Color(color),
    null => AppColors.textMuted,
  },
);

/// A profile as it is shown: its folder's name, `claude-promov`.
String profileLabel(String profile) => p.basename(profile).substring(1);

/// Where [project] is, as shown: `LUNAR › hub-lunar`; null when it is in
/// no company.
String? placeOf(Project project) =>
    switch (Companies.instance.of(project.path)) {
      final company? => '${company.name} › ${project.name}',
      null => null,
    };

/// [title] after where [project] is, if it is in a company.
String withPlace(Project project, String title) => switch (placeOf(project)) {
  final place? => '$place  ·  $title',
  null => title,
};

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
  var color = editing?.color;
  var icon = editing?.icon;
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
          companies.put(text, profile, color: color, icon: icon);
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
                const SizedBox(height: 12),
                Text(l10n.companyColor),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final option in [null, ...companyColors])
                      _Choice(
                        selected: option == color,
                        onTap: () => setState(() => color = option),
                        child: option == null
                            ? Icon(
                                Icons.block_rounded,
                                size: 14,
                                color: AppColors.textFaint,
                              )
                            : Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Color(option),
                                  shape: BoxShape.circle,
                                ),
                              ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(l10n.companyIcon),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final MapEntry(:key, :value) in companyIcons.entries)
                      _Choice(
                        selected: key == (icon ?? 'folder'),
                        onTap: () => setState(() => icon = key),
                        child: Icon(
                          value,
                          size: 16,
                          color: color == null
                              ? AppColors.textMuted
                              : Color(color!),
                        ),
                      ),
                  ],
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

/// One of the colors or icons to pick, framed when picked.
class _Choice extends StatelessWidget {
  const _Choice({
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(6),
    child: Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: selected ? AppColors.textMuted : Colors.transparent,
        ),
      ),
      child: child,
    ),
  );
}
