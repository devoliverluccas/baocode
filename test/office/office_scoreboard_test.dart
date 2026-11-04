import 'package:flutter_test/flutter_test.dart';

import 'package:baocode/l10n/l10n.dart';
import 'package:baocode/office/office_scoreboard.dart';
import 'package:baocode/usage/usage_prices.dart';
import 'package:baocode/usage/usage_record.dart';

void main() {
  final start = DateTime(2026, 11, 4, 9);
  UsageCall call(
    String session,
    String project,
    int minute,
    int minutes, {
    String provider = 'claude-code',
  }) => UsageCall(
    at: start.add(Duration(minutes: minute)),
    duration: Duration(minutes: minutes),
    status: 200,
    provider: provider,
    model: 'claude-sonnet-5-5',
    input: 1000000,
    session: session,
    project: project,
  );

  // Two projects of Acme's, one of no company's, one not the sidebar's.
  String? buildingOf(UsageCall call) => switch (call.project) {
    'dashboard' || 'hub' => 'Acme',
    'loose' => '',
    _ => null,
  };

  test('groups by company: its conversations, time once, cost', () {
    final scores = scoresOf(
      [
        call('a', 'dashboard', 0, 10),
        // Overlaps a's: counted once.
        call('b', 'hub', 5, 10),
        call('a', 'dashboard', 30, 5),
        call('c', 'loose', 0, 1, provider: 'somewhere'),
        call('d', 'gone', 0, 60),
      ],
      buildingOf,
      prices: UsagePrices(),
    );
    expect(scores.keys, unorderedEquals(['Acme', '']));
    final acme = scores['Acme']!;
    expect(acme.conversations, 2);
    expect(acme.working, const Duration(minutes: 20));
    expect(acme.cost, isNotNull);
    expect(
      acme.label(englishLocalizations),
      allOf(startsWith('2 conversations · 20m'), contains(r'$')),
    );
    // Unpriced: the count and the time only.
    final loose = scores['']!;
    expect(loose.cost, isNull);
    expect(loose.label(englishLocalizations), '1 conversation · 1m 0s');
  });
}
