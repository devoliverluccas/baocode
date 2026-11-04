import 'dart:collection';

import 'office_model.dart';
import 'office_sprites.dart' show OfficeFacing;

/// A tile of a room's grid: its column and row.
typedef Tile = ({int col, int row});

/// A thing in a room, drawn from [asset] (a picture of assets/office/
/// furniture) with its bottom left at [tile]'s bottom left; or, without
/// one, drawn by the painter itself (the server).
class OfficePiece {
  const OfficePiece(
    this.tile, {
    this.asset,
    this.onWall = false,
    this.seat = false,
  });

  final Tile tile;
  final String? asset;

  /// Hung on the wall: drawn before the floor's furniture and characters.
  final bool onWall;

  /// Sat on (a chair, the sofa): drawn under who sits on it.
  final bool seat;
}

/// Where a character sits or stands, and the way it faces there.
class Seat {
  const Seat(this.tile, this.facing, {this.pc = false});

  final Tile tile;
  final OfficeFacing facing;

  /// At a desk with a PC.
  final bool pc;
}

/// A room's grid and furniture, as Pixel Agents' OfficeLayout: the same
/// for every room, 4 desks for [OfficeRoom.maxVisible] characters and 4
/// more behind for their teams.
///
///     col  0 1 2 3 4 5 6 7 8
///     r0   B B W N H H C D W   wall: bookshelf, window, whiteboard, clock, door
///     r1   . . . . . . . . .
///     r2   K K K . K K K . S   desks with 2 PCs each; S the server
///     r3   K K K . K K K . S
///     r4   h . h . h . h . .   chairs
///     r5   . . . . . . . . c   coffee
///     r6   K K K . K K K . .   the teams' desks
///     r7   K K K . K K K . P   plant
///     r8   h . h . h . h . .
class OfficeLayout {
  OfficeLayout._();

  static final room = OfficeLayout._();

  static const tile = 16.0;
  static const cols = 9, rows = 9;

  /// In the sprites' pixels: the wall's pieces stand a tile above row 0.
  static const width = cols * tile, height = (rows + 1) * tile;

  final Tile door = (col: 7, row: 0);

  /// The wall: row 0, but for the [door].
  bool isWall(Tile at) => at.row == 0 && at != door;

  /// The tiles furniture stands on.
  final Set<Tile> blocked = {
    for (final row in [2, 3, 6, 7])
      for (var col = 0; col < 7; col++)
        if (col != 3) (col: col, row: row),
    (col: 8, row: 2),
    (col: 8, row: 3),
    (col: 8, row: 5),
    (col: 8, row: 7),
  };

  /// In drawing order, back to front.
  final List<OfficePiece> pieces = [
    const OfficePiece(
      (col: 0, row: 0),
      asset: 'DOUBLE_BOOKSHELF/DOUBLE_BOOKSHELF',
      onWall: true,
    ),
    const OfficePiece(
      (col: 3, row: 0),
      asset: 'SMALL_PAINTING/SMALL_PAINTING',
      onWall: true,
    ),
    const OfficePiece(
      (col: 4, row: 0),
      asset: 'WHITEBOARD/WHITEBOARD',
      onWall: true,
    ),
    const OfficePiece((col: 6, row: 0), asset: 'CLOCK/CLOCK', onWall: true),
    for (final row in [3, 7]) ...[
      for (final col in [0, 4])
        OfficePiece((col: col, row: row), asset: 'DESK/DESK_FRONT'),
      // On the desks, after them.
      for (final col in [0, 2, 4, 6])
        OfficePiece((col: col, row: row), asset: 'PC/PC_FRONT_OFF'),
      for (final col in [0, 2, 4, 6])
        OfficePiece(
          (col: col, row: row + 1),
          asset: 'WOODEN_CHAIR/WOODEN_CHAIR_BACK',
          seat: true,
        ),
    ],
    const OfficePiece((col: 8, row: 3)),
    const OfficePiece((col: 8, row: 7), asset: 'PLANT/PLANT'),
    const OfficePiece((col: 8, row: 5), asset: 'COFFEE/COFFEE'),
  ];

  /// The desks' chairs, facing their PCs.
  final List<Seat> desks = [
    for (final col in [0, 2, 4, 6])
      Seat((col: col, row: 4), OfficeFacing.up, pc: true),
  ];

  /// The teams' desks, behind: for team members only.
  final List<Seat> teamDesks = [
    for (final col in [0, 2, 4, 6])
      Seat((col: col, row: 8), OfficeFacing.up, pc: true),
  ];

  bool isWalkable(Tile at) =>
      at.col >= 0 &&
      at.col < cols &&
      at.row >= 0 &&
      at.row < rows &&
      !isWall(at) &&
      !blocked.contains(at);

  /// The tiles from [from] to [to], [from] left out; empty where [to] is
  /// [from] or out of reach. BFS on 4 neighbours, as tileMap.findPath.
  List<Tile> findPath(Tile from, Tile to) {
    if (from == to || !isWalkable(to)) return const [];
    final parent = <Tile, Tile>{};
    final queue = Queue.of([from]);
    final seen = {from};
    while (queue.isNotEmpty) {
      final at = queue.removeFirst();
      if (at == to) {
        final path = <Tile>[];
        for (var step = to; step != from; step = parent[step]!) {
          path.add(step);
        }
        return path.reversed.toList();
      }
      for (final (dc, dr) in const [(0, -1), (0, 1), (-1, 0), (1, 0)]) {
        final next = (col: at.col + dc, row: at.row + dr);
        if (!seen.add(next) || !isWalkable(next)) continue;
        parent[next] = at;
        queue.add(next);
      }
    }
    return const [];
  }

  /// The desk of one whose [hash] is that ([OfficeAgent.hash]): the same
  /// one each time, or the next not [taken] after it; null when all are.
  Seat? deskFor(int hash, Set<Tile> taken) =>
      [for (var i = 0; i < desks.length; i++) desks[(hash + i) % desks.length]]
          .where((seat) => !taken.contains(seat.tile))
          .firstOrNull;

  /// Where a team member of the one at [lead] sits, none of [taken]: the
  /// free desk nearest it; null when all are.
  Seat? teamSeat(Seat lead, Set<Tile> taken) {
    int far(Seat seat) =>
        (seat.tile.col - lead.tile.col).abs() +
        (seat.tile.row - lead.tile.row).abs();
    return ([
            ...desks,
            ...teamDesks,
          ].where((seat) => !taken.contains(seat.tile)).toList()
          ..sort((a, b) => far(a).compareTo(far(b))))
        .firstOrNull;
  }
}
