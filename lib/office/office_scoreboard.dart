import 'dart:async';

import 'package:flutter/foundation.dart';

import '../chat/widgets/agent_step.dart' show AgentStep;
import '../l10n/l10n.dart';
import '../usage/usage_ledger.dart';
import '../usage/usage_prices.dart';
import '../usage/usage_record.dart';

/// A building's day so far: on its roof.
class OfficeScore {
  const OfficeScore({
    required this.conversations,
    required this.working,
    this.cost,
  });

  /// Conversations that called a model today.
  final int conversations;

  /// How long its models answered, overlaps counted once.
  final Duration working;

  /// What it came to; null when nothing was priced.
  final UsageCost? cost;

  /// "3 conversations · 1h 5m · $2.40"; the cost left out when unknown.
  String label(AppLocalizations l10n) => [
    l10n.officeScoreConversations(conversations),
    AgentStep.formatDuration(working, l10n: l10n),
    if (cost case final cost? when !cost.isEmpty)
      UsagePrices.money(cost.byCurrency.values.first, cost.currency!),
  ].join(' · ');
}

/// [calls] by building: [buildingOf] names a call's (null: none of the
/// campus's, left out).
Map<String, OfficeScore> scoresOf(
  Iterable<UsageCall> calls,
  String? Function(UsageCall call) buildingOf, {
  UsagePrices? prices,
}) {
  final byBuilding = <String, List<UsageCall>>{};
  for (final call in calls) {
    if (buildingOf(call) case final building?) {
      (byBuilding[building] ??= []).add(call);
    }
  }
  return {
    for (final MapEntry(key: building, value: mine) in byBuilding.entries)
      building: OfficeScore(
        conversations: {for (final call in mine) ?call.session}.length,
        working: _union(mine),
        cost: switch ((prices ?? UsagePrices.current).costOf(mine)) {
          final cost when cost.isEmpty => null,
          final cost => cost,
        },
      ),
  };
}

/// The time covered by [calls]' spans, each once.
Duration _union(List<UsageCall> calls) {
  final spans = [
    for (final call in calls) (call.at, call.at.add(call.duration)),
  ]..sort((a, b) => a.$1.compareTo(b.$1));
  var total = Duration.zero;
  DateTime? start, end;
  for (final (from, until) in spans) {
    if (end == null || from.isAfter(end)) {
      if (start != null) total += end!.difference(start);
      (start, end) = (from, until);
    } else if (until.isAfter(end)) {
      end = until;
    }
  }
  if (start != null) total += end!.difference(start);
  return total;
}

/// Today's [scoresOf] the [ledger]'s calls, read again as it keeps more
/// (or [also] changes how they group); empty while they load, or when
/// calls are not kept.
class OfficeScores extends ChangeNotifier {
  OfficeScores(this.ledger, this.buildingOf, {this.also}) {
    ledger.addListener(_load);
    also?.addListener(_load);
    _load();
  }

  final UsageLedger ledger;
  final String? Function(UsageCall call) buildingOf;
  final Listenable? also;

  Map<String, OfficeScore> get value => _value;
  Map<String, OfficeScore> _value = const {};
  int _loads = 0;
  bool _disposed = false;

  Future<void> _load() async {
    final load = ++_loads;
    final now = DateTime.now();
    try {
      final calls = await ledger.range(
        from: DateTime(now.year, now.month, now.day),
      );
      if (_disposed || load != _loads) return;
      _value = scoresOf(calls, buildingOf);
      notifyListeners();
    } catch (_) {
      // No roof's numbers, nothing else amiss.
    }
  }

  @override
  void dispose() {
    _disposed = true;
    ledger.removeListener(_load);
    also?.removeListener(_load);
    super.dispose();
  }
}
