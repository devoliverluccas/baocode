import 'dart:io';

import 'package:bao_remote/local.dart' show ClaudeEnvironment;
import 'package:baocode/l10n/app_localizations.dart';
import 'package:baocode/workspace/companies.dart';
import 'package:baocode/workspace/company_dialog.dart';
import 'package:baocode/workspace/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  test('a project runs with its company\'s Claude, kept across loads', () {
    final dir = Directory.systemTemp.createTempSync('companies');
    addTearDown(() => dir.deleteSync(recursive: true));
    ClaudeEnvironment.profilesFile = p.join(dir.path, 'claude-profiles.json');
    Companies.file = p.join(dir.path, 'companies.json');
    addTearDown(() => ClaudeEnvironment.profilesFile = Companies.file = null);
    final companies = Companies.instance;
    final project = p.join(dir.path, 'site');

    companies.put('PROMOV', '/h/.claude-promov');
    companies.assign(project, 'PROMOV');
    expect(companies.of(project)?.name, 'PROMOV');
    expect(ClaudeEnvironment.profileFor(project), '/h/.claude-promov');

    // Its Claude changed: the projects follow.
    companies.put('PROMOV', '/h/.claude-stark');
    expect(ClaudeEnvironment.profileFor(project), '/h/.claude-stark');

    companies.rename('PROMOV', 'LUTECH');
    companies.load();
    expect(companies.of(project)?.name, 'LUTECH');

    // Its look and whether it is hidden are kept, renamed too.
    companies.put(
      'LUTECH',
      '/h/.claude-stark',
      color: 0xFF81C784,
      icon: 'moon',
    );
    companies.setHidden('LUTECH', true);
    companies.load();
    final kept = companies.byName('LUTECH')!;
    expect((kept.color, kept.icon, kept.hidden), (0xFF81C784, 'moon', true));

    // Deleted: the project is in none, still with the Claude it ran with.
    companies.remove('LUTECH');
    expect(companies.of(project), isNull);
    expect(ClaudeEnvironment.profileFor(project), '/h/.claude-stark');
  });

  testWidgets('a project in no company says so, and is put in one from it', (
    tester,
  ) async {
    final dir = Directory.systemTemp.createTempSync('companies');
    addTearDown(() => dir.deleteSync(recursive: true));
    ClaudeEnvironment.profilesFile = p.join(dir.path, 'claude-profiles.json');
    addTearDown(() => ClaudeEnvironment.profilesFile = null);
    final companies = Companies.instance;
    final project = Project.at(p.join(dir.path, 'loja'));
    companies.put('LUNAR', '/h/.claude-lunar');
    addTearDown(() => companies.remove('LUNAR'));
    expect(placeOf(project), isNull);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: NoCompanyNotice(path: project.path)),
      ),
    );
    await tester.tap(find.textContaining('Default account'));
    await tester.pumpAndSettle();
    expect(find.text('New company…'), findsOneWidget);
    await tester.tap(find.text('LUNAR'));
    await tester.pumpAndSettle();
    expect(companies.of(project.path)?.name, 'LUNAR');
    expect(placeOf(project), 'LUNAR › loja');
  });

  test('the next agent needing you: waiting ones, then unread, round', () {
    const statuses = {
      'a': ThreadStatus.unread,
      'b': ThreadStatus.idle,
      'c': ThreadStatus.needsInput,
      'd': ThreadStatus.running,
      'e': ThreadStatus.unread,
    };
    final order = statuses.keys.toList();
    String? next(String? current) =>
        nextNeedingYou(order, current, (id) => statuses[id]!);
    expect(next(null), 'c');
    expect(next('b'), 'c');
    expect(next('c'), 'a');
    expect(next('a'), 'e');
    expect(next('e'), 'c');
    expect(nextNeedingYou(['b', 'd'], 'b', (id) => statuses[id]!), isNull);
  });
}
