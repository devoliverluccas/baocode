import 'dart:collection';
import 'dart:math' as math;

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

  /// At a desk with a PC: those are taken first ([OfficeLayout.freeSeat]).
  final bool pc;
}

/// A room's grid and furniture, as Pixel Agents' OfficeLayout: the same
/// for every room, 4 desks for [OfficeRoom.maxVisible] characters.
///
///     col  0 1 2 3 4 5 6 7 8
///     r0   B B W N H H C D W   wall: bookshelf, window, whiteboard, clock, door
///     r1   . . . . . . . . .
///     r2   K K K . K K K . S   desks with 2 PCs each; S the server
///     r3   K K K . K K K . S
///     r4   h . h . h . h . .   chairs
///     r5   . . . . . F F c P   sofa, coffee, plant
///     r6   . . . . . . . . .
class OfficeLayout {
  OfficeLayout._();

  static final room = OfficeLayout._();

  static const tile = 16.0;
  static const cols = 9, rows = 7;

  /// In the sprites' pixels: the wall's pieces stand a tile above row 0.
  static const width = cols * tile, height = (rows + 1) * tile;

  final Tile door = (col: 7, row: 0);

  /// The wall: row 0, but for the [door].
  bool isWall(Tile at) => at.row == 0 && at != door;

  /// The tiles furniture stands on.
  final Set<Tile> blocked = {
    for (var col = 0; col < 7; col++)
      if (col != 3) ...[(col: col, row: 2), (col: col, row: 3)],
    (col: 8, row: 2),
    (col: 8, row: 3),
    (col: 7, row: 5),
    (col: 8, row: 5),
  };

  /// In drawing order, back to front.
  final List<OfficePiece> pieces = const [
    OfficePiece(
      (col: 0, row: 0),
      asset: 'DOUBLE_BOOKSHELF/DOUBLE_BOOKSHELF',
      onWall: true,
    ),
    OfficePiece(
      (col: 3, row: 0),
      asset: 'SMALL_PAINTING/SMALL_PAINTING',
      onWall: true,
    ),
    OfficePiece((col: 4, row: 0), asset: 'WHITEBOARD/WHITEBOARD', onWall: true),
    OfficePiece((col: 6, row: 0), asset: 'CLOCK/CLOCK', onWall: true),
    OfficePiece((col: 0, row: 3), asset: 'DESK/DESK_FRONT'),
    OfficePiece((col: 4, row: 3), asset: 'DESK/DESK_FRONT'),
    // On the desks, after them.
    OfficePiece((col: 0, row: 3), asset: 'PC/PC_FRONT_OFF'),
    OfficePiece((col: 2, row: 3), asset: 'PC/PC_FRONT_OFF'),
    OfficePiece((col: 4, row: 3), asset: 'PC/PC_FRONT_OFF'),
    OfficePiece((col: 6, row: 3), asset: 'PC/PC_FRONT_OFF'),
    OfficePiece((col: 8, row: 3)),
    OfficePiece(
      (col: 0, row: 4),
      asset: 'WOODEN_CHAIR/WOODEN_CHAIR_BACK',
      seat: true,
    ),
    OfficePiece(
      (col: 2, row: 4),
      asset: 'WOODEN_CHAIR/WOODEN_CHAIR_BACK',
      seat: true,
    ),
    OfficePiece(
      (col: 4, row: 4),
      asset: 'WOODEN_CHAIR/WOODEN_CHAIR_BACK',
      seat: true,
    ),
    OfficePiece(
      (col: 6, row: 4),
      asset: 'WOODEN_CHAIR/WOODEN_CHAIR_BACK',
      seat: true,
    ),
    OfficePiece((col: 8, row: 5), asset: 'PLANT/PLANT'),
    OfficePiece((col: 5, row: 5), asset: 'SOFA/SOFA_FRONT', seat: true),
    OfficePiece((col: 7, row: 5), asset: 'COFFEE/COFFEE'),
  ];

  /// The desks' chairs, facing their PCs.
  final List<Seat> desks = [
    for (final col in [0, 2, 4, 6])
      Seat((col: col, row: 4), OfficeFacing.up, pc: true),
  ];

  final List<Seat> sofa = const [
    Seat((col: 5, row: 5), OfficeFacing.down),
    Seat((col: 6, row: 5), OfficeFacing.down),
  ];

  /// Where each errand away from the desk is done, standing.
  late final Map<OfficeActivity, List<Seat>> spots = {
    OfficeActivity.reading: const [
      Seat((col: 0, row: 1), OfficeFacing.up),
      Seat((col: 1, row: 1), OfficeFacing.up),
    ],
    OfficeActivity.window: const [Seat((col: 3, row: 1), OfficeFacing.up)],
    OfficeActivity.server: const [
      Seat((col: 7, row: 3), OfficeFacing.right),
      Seat((col: 7, row: 2), OfficeFacing.right),
    ],
    OfficeActivity.coffee: sofa,
  };

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

  /// A desk not [taken], those at a PC first, at random among those, as
  /// officeState.findFreeSeat; null when all are.
  Seat? freeSeat(Set<Tile> taken, [math.Random? random]) {
    final free = desks.where((seat) => !taken.contains(seat.tile)).toList();
    final pick = free.any((seat) => seat.pc)
        ? free.where((seat) => seat.pc).toList()
        : free;
    if (pick.isEmpty) return null;
    return pick[(random ?? _random).nextInt(pick.length)];
  }

  /// The first of [activity]'s spots not [taken]; null when there are none
  /// free (or none for it: at the desk, then).
  Seat? spotFor(OfficeActivity activity, Set<Tile> taken) =>
      spots[activity]?.where((spot) => !taken.contains(spot.tile)).firstOrNull;

  /// Beside [seat], for an intern: a floor tile next to it, not a seat,
  /// facing it.
  Seat besides(Seat seat) {
    final seats = {
      for (final s in [...desks, ...sofa]) s.tile,
    };
    final (col, row) = (seat.tile.col, seat.tile.row);
    return [
              ((col: col + 1, row: row), OfficeFacing.left),
              ((col: col - 1, row: row), OfficeFacing.right),
              ((col: col, row: row + 1), OfficeFacing.up),
            ]
            .where((at) => isWalkable(at.$1) && !seats.contains(at.$1))
            .map((at) => Seat(at.$1, at.$2))
            .firstOrNull ??
        seat;
  }

  static final _random = math.Random();
}
