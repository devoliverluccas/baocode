import 'dart:io';

import 'package:bao_remote/local.dart' show ClaudeEnvironment;
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  test('a project runs with the profile picked for it or a folder above', () {
    final dir = Directory.systemTemp.createTempSync('profiles');
    addTearDown(() => dir.deleteSync(recursive: true));
    ClaudeEnvironment.profilesFile = p.join(dir.path, 'claude-profiles.json');
    addTearDown(() => ClaudeEnvironment.profilesFile = null);
    final project = p.join(dir.path, 'promov');
    expect(ClaudeEnvironment.profileFor(project), isNull);
    ClaudeEnvironment.setProfile(project, '/home/.claude-promov');
    expect(
      ClaudeEnvironment.profileFor(p.join(project, 'api')),
      '/home/.claude-promov',
    );
    expect(
      ClaudeEnvironment.stateDirectory(const {}, cwd: project),
      {'CLAUDE_CONFIG_DIR': '/home/.claude-promov'},
    );
    ClaudeEnvironment.setProfile(project, '/home/.claude-stark');
    expect(ClaudeEnvironment.profiles(), {project: '/home/.claude-stark'});
    expect(ClaudeEnvironment.profileFor(dir.path), isNull);
  });
}
