// A key/value store kept as one JSON object file, written atomically (a
// temporary file renamed over it) a moment after it changes: the
// extensions' global and workspace state (VS Code keeps them in
// state.vscdb), and the window area's own small state (trusted URI
// handlers, authentication access, hidden status bar entries).

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

/// What changed in a [JsonStateStore]: [key] set to [value] (null when
/// removed).
typedef JsonStateChange = ({String key, String? value});

final class JsonStateStore {
  JsonStateStore(
    this.path, {
    this.writeDelay = const Duration(milliseconds: 100),
  });

  /// The JSON file.
  final String path;

  /// How long after a change it is written (changes in between go with it).
  final Duration writeDelay;

  Map<String, String>? _values;
  Future<void>? _loading;
  Timer? _timer;
  Future<void> _writing = Future.value();
  bool _dirty = false;
  final _changes = StreamController<JsonStateChange>.broadcast(sync: true);

  /// Every change made with [set] or [remove].
  Stream<JsonStateChange> get changes => _changes.stream;

  /// Reads the file once; a missing or broken one is empty.
  Future<void> load() => _loading ??= () async {
    final values = <String, String>{};
    try {
      final file = File(path);
      if (await file.exists()) {
        final json = jsonDecode(await file.readAsString());
        if (json is Map) {
          for (final MapEntry(:key, :value) in json.entries) {
            if (key is String && value is String) values[key] = value;
          }
        }
      }
    } on Object {
      // A broken file starts over.
    }
    _values = {...values, ...?_values};
  }();

  Map<String, String> get _map => _values ??= {};

  bool get isLoaded => _values != null && _loading != null;

  /// The value of [key]; null when none (or before [load]).
  String? get(String key) => _map[key];

  /// The value of [key] as JSON; null when none or not JSON.
  Object? getJson(String key) {
    final raw = get(key);
    if (raw == null) return null;
    try {
      return jsonDecode(raw);
    } on FormatException {
      return null;
    }
  }

  /// All keys, sorted.
  List<String> get keys => _map.keys.toList()..sort();

  void set(String key, String value) {
    if (_map[key] == value) return;
    _map[key] = value;
    _changed(key, value);
  }

  void setJson(String key, Object? value) => set(key, jsonEncode(value));

  void remove(String key) {
    if (_map.remove(key) == null) return;
    _changed(key, null);
  }

  void _changed(String key, String? value) {
    _dirty = true;
    _timer?.cancel();
    _timer = Timer(writeDelay, () => unawaited(flush()));
    _changes.add((key: key, value: value));
  }

  /// Writes pending changes now.
  Future<void> flush() {
    _timer?.cancel();
    _timer = null;
    if (!_dirty) return _writing;
    _dirty = false;
    final snapshot = jsonEncode(_map);
    return _writing = _writing.then((_) => writeAtomically(path, snapshot));
  }

  Future<void> dispose() async {
    await flush();
    await _changes.close();
  }
}

/// The temporary files [writeAtomically] made so far.
int _temps = 0;

/// Writes [contents] to [path] through a temporary file beside it renamed
/// over it, so a reader never sees half of it.
Future<void> writeAtomically(String path, String contents) async {
  final dir = Directory(p.dirname(path));
  await dir.create(recursive: true);
  // Numbered as well: two writes of the same file in one tick of a coarse
  // clock (Windows') would share it otherwise.
  final temp = File(
    '$path.${pid}_${DateTime.now().microsecondsSinceEpoch}_${_temps++}.tmp',
  );
  try {
    await temp.writeAsString(contents, flush: true);
    // Windows refuses it while another write of the file is renaming over
    // it: tried again a moment later, a few times.
    for (var tries = 1; ; tries++) {
      try {
        await temp.rename(path);
        break;
      } on FileSystemException {
        if (!Platform.isWindows || tries == 5) rethrow;
        await Future<void>.delayed(Duration(milliseconds: 10 * tries));
      }
    }
  } on Object {
    if (await temp.exists()) await temp.delete();
    rethrow;
  }
}
