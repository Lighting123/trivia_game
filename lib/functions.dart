import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_game/screens/end_game_screen.dart';

import 'screens/game_screen.dart';

void checkAnswer(int questionNumber, BuildContext context, WidgetRef ref) {
  if (alreadySelected == false) {
    String answer = questions[questionNumber].answers[answerSelected];
    String correctAnswer = questions[questionNumber].answer;
    if (answer == correctAnswer) {
      ref.read(pointsProvider.notifier).increase(20);
      var snackBar = SnackBar(
        content: const Text('Yay! You got the answer correct'),
        action: SnackBarAction(
          label: 'Continue',
          onPressed: () {
            checkMoreAnswers(ref, context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              title: const Text("You gave the wrong answer"),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      checkMoreAnswers(ref, context);
                    },
                    child: const Text("Continue"))
              ],
            );
          });
    }
    alreadySelected = true;
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            title: const Text("You already answered this question"),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    checkMoreAnswers(ref, context);
                  },
                  child: const Text("Next"))
            ],
          );
        });
  }
}

void checkMoreAnswers(WidgetRef ref, BuildContext context) {
  int questionNumber = ref.read(questionNumberProvider);
  questionNumber += 1;
  if (questionNumber == questions.length) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EndGameScreen(
                  points: ref.read(pointsProvider),
                )));
  } else {
    ref.read(questionNumberProvider.notifier).increment();
    alreadySelected = false;
  }
}

int questionsAnswered(WidgetRef ref) {
  int points = ref.read(pointsProvider);
  if (points == 0) {
    return 0;
  } else {
    double questionsAnswered = points / 20;
    return questionsAnswered.toInt();
  }
}
