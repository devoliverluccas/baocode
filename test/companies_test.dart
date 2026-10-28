import 'dart:io';

import 'package:bao_remote/local.dart' show ClaudeEnvironment;
import 'package:baocode/workspace/companies.dart';
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

    // Deleted: the project is in none, still with the Claude it ran with.
    companies.remove('LUTECH');
    expect(companies.of(project), isNull);
    expect(ClaudeEnvironment.profileFor(project), '/h/.claude-stark');
  });
}
