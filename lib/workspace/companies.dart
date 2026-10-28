import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../kernel/claude_code/claude_environment.dart';

/// A company the projects are grouped under in the sidebar, and the Claude
/// Code profile (its config dir, `~/.claude-promov`) its projects run with.
class Company {
  const Company(
    this.name,
    this.profile, {
    this.color,
    this.icon,
    this.hidden = false,
  });

  factory Company.fromJson(Map<Object?, Object?> json) => Company(
    json['name'] as String,
    json['profile'] as String,
    color: json['color'] as int?,
    icon: json['icon'] as String?,
    hidden: json['hidden'] == true,
  );

  final String name;
  final String profile;

  /// Its folder's color in the sidebar, as ARGB; null: the list's.
  final int? color;

  /// Its icon's name (see `companyIcons`); null: a folder.
  final String? icon;

  /// Out of the way: listed under the hidden companies, its projects not.
  final bool hidden;

  Company copyWith({
    String? name,
    String? profile,
    int? Function()? color,
    String? Function()? icon,
    bool? hidden,
  }) => Company(
    name ?? this.name,
    profile ?? this.profile,
    color: color == null ? this.color : color(),
    icon: icon == null ? this.icon : icon(),
    hidden: hidden ?? this.hidden,
  );

  Map<String, Object?> toJson() => {
    'name': name,
    'profile': profile,
    'color': ?color,
    'icon': ?icon,
    if (hidden) 'hidden': true,
  };
}

/// The companies and which one each project folder is in, kept in [file]
/// as `{companies: [...], projects: {folder: company}}`. A project in one
/// runs with its profile (see [ClaudeEnvironment.setProfile]).
class Companies extends ChangeNotifier {
  Companies._();

  static final instance = Companies._();

  /// Where they are kept; null keeps them in memory only.
  static String? file;

  final List<Company> _list = [];
  final Map<String, String> _projects = {};

  List<Company> get list => List.unmodifiable(_list);

  void load() {
    final path = file;
    if (path == null) return;
    try {
      final json = jsonDecode(File(path).readAsStringSync()) as Map;
      _list
        ..clear()
        ..addAll([
          for (final c in json['companies'] as List) Company.fromJson(c as Map),
        ]);
      _projects
        ..clear()
        ..addAll((json['projects'] as Map).cast<String, String>());
    } on Object {
      // None kept yet, or unreadable: start empty.
    }
  }

  void _save() {
    notifyListeners();
    final path = file;
    if (path == null) return;
    File(path)
      ..createSync(recursive: true)
      ..writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert({
          'companies': [for (final c in _list) c.toJson()],
          'projects': _projects,
        }),
      );
  }

  Company? byName(String name) =>
      _list.where((c) => c.name == name).firstOrNull;

  /// The company [path] is in, if any.
  Company? of(String path) {
    for (final MapEntry(:key, :value) in _projects.entries) {
      if (p.equals(key, path)) return byName(value);
    }
    return null;
  }

  /// Adds a company, or changes the profile of the one named so; its
  /// projects follow.
  void put(String name, String profile, {int? color, String? icon}) {
    final i = _list.indexWhere((c) => c.name == name);
    if (i < 0) {
      _list.add(Company(name, profile, color: color, icon: icon));
    } else {
      _list[i] = _list[i].copyWith(
        profile: profile,
        color: () => color,
        icon: () => icon,
      );
    }
    for (final MapEntry(:key, :value) in _projects.entries) {
      if (value == name) ClaudeEnvironment.setProfile(key, profile);
    }
    _save();
  }

  void rename(String from, String to) {
    final company = byName(from);
    if (company == null || from == to || byName(to) != null) return;
    _list[_list.indexOf(company)] = company.copyWith(name: to);
    _projects.updateAll((_, value) => value == from ? to : value);
    _save();
  }

  /// Hides the company named [name], or shows it again.
  void setHidden(String name, bool hidden) {
    final i = _list.indexWhere((c) => c.name == name);
    if (i < 0 || _list[i].hidden == hidden) return;
    _list[i] = _list[i].copyWith(hidden: hidden);
    _save();
  }

  /// Takes the company away; its projects stay, in none, with the profile
  /// they ran with.
  void remove(String name) {
    _list.removeWhere((c) => c.name == name);
    _projects.removeWhere((_, value) => value == name);
    _save();
  }

  /// Puts [path] in [name], to run with its profile.
  void assign(String path, String name) {
    final company = byName(name);
    if (company == null) return;
    _projects
      ..removeWhere((key, _) => p.equals(key, path))
      ..[path] = name;
    ClaudeEnvironment.setProfile(path, company.profile);
    _save();
  }
}
