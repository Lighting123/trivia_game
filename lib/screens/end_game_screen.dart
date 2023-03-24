import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_game/functions.dart';
import 'package:trivia_game/screens/game_screen.dart';

class EndGameScreen extends ConsumerWidget {
  const EndGameScreen({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your game stats"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Points: ${points.toString()}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "Questions Correct: ${questionsAnswered(ref)}/${questions.length}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () {
                    ref.read(checkBoxValue1Provider.notifier).toggle(false);
                    ref.read(checkBoxValue2Provider.notifier).toggle(false);
                    ref.read(checkBoxValue3Provider.notifier).toggle(false);
                    ref.read(questionNumberProvider.notifier).reset();
                    alreadySelected = false;
                    answerSelected = 0;
                    ref.read(pointsProvider.notifier).reset();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Start again")))
        ]),
      ),
    );
  }
}
