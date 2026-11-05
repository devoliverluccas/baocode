import 'package:flutter/material.dart';

import 'board_card.dart';
import 'board_data.dart';

/// The board's Cartões: the cards in a grid, by company and project.
// ponytail: placeholder list, replaced by the view's own layout.
class BoardCardsView extends StatelessWidget {
  const BoardCardsView({super.key, required this.data, required this.actions});

  final BoardData data;
  final BoardActions actions;

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.all(12),
    itemCount: data.threads.length,
    separatorBuilder: (_, _) => const SizedBox(height: 8),
    itemBuilder: (context, i) =>
        ThreadCard(thread: data.threads[i], actions: actions),
  );
}
