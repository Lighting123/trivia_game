import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_game/functions.dart';
import 'package:trivia_game/question_data.dart';

import '../notifiers.dart';

List<QuestionData> questions = [
  QuestionData(
      question: "What is 2+2",
      answer: "4",
      answers: ["1", "2", "4"],
      category: "Math"),
  QuestionData(
      question: "Who ivented the computer",
      answer: "Charles Babbage",
      answers: ["Charles Babbage", "Abraham Lincon", "Random Person"],
      category: "Science"),
  QuestionData(
      question: "When did Nigeria gain independence",
      answer: "1960",
      answers: ["2018", "1960", "1980"],
      category: "History"),
  QuestionData(
      question: "What is 7 multiplied by 4",
      answer: "28",
      answers: ["10", "26", "28"],
      category: "Math")
];

final pointsProvider = StateNotifierProvider<PointsNotifier, int>((ref) {
  return PointsNotifier(number: 0);
});
bool alreadySelected = false;
int answerSelected = 0;
final checkBoxValue1Provider =
    StateNotifierProvider<CheckBoxValueNotifier, bool>((ref) {
  return CheckBoxValueNotifier(value: false);
});
final checkBoxValue2Provider =
    StateNotifierProvider<CheckBoxValueNotifier, bool>((ref) {
  return CheckBoxValueNotifier(value: false);
});
final checkBoxValue3Provider =
    StateNotifierProvider<CheckBoxValueNotifier, bool>((ref) {
  return CheckBoxValueNotifier(value: false);
});
final questionNumberProvider =
    StateNotifierProvider<QuestionNumberNotifier, int>((ref) {
  return QuestionNumberNotifier(number: 0);
});

// ignore: must_be_immutable
class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var checkBoxValue1 = ref.watch(checkBoxValue1Provider);
    var checkBoxValue2 = ref.watch(checkBoxValue2Provider);
    var checkBoxValue3 = ref.watch(checkBoxValue3Provider);
    var questionNumber = ref.watch(questionNumberProvider);
    var points = ref.watch(pointsProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Game"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Question $questionNumber of ${questions.length}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Max Points: ${20 * questions.length}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Points: $points",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 16, right: 16, left: 16, bottom: 0),
                child: Text("${questions[questionNumber].question} ?")),
            Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Category: ${questions[questionNumber].category}",
                  style: Theme.of(context).textTheme.labelSmall,
                )),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnswerItem(
                    checkBoxValue: checkBoxValue1,
                    label: questions[questionNumber].answers[0],
                    index: 0)),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnswerItem(
                  checkBoxValue: checkBoxValue2,
                  label: questions[questionNumber].answers[1],
                  index: 1,
                )),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnswerItem(
                  checkBoxValue: checkBoxValue3,
                  label: questions[questionNumber].answers[2],
                  index: 2,
                )),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: OutlinedButton(
                    onPressed: () {
                      checkAnswer(questionNumber, context, ref);
                    },
                    child: const Text("Check"))),
          ],
        ));
  }
}

class AnswerItem extends ConsumerWidget {
  const AnswerItem(
      {super.key,
      required this.checkBoxValue,
      required this.label,
      required this.index});

  final bool checkBoxValue;
  final String label;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(children: [
      Checkbox(
        value: checkBoxValue,
        onChanged: (newValue) {
          if (index == 0) {
            answerSelected = 0;
            ref.read(checkBoxValue1Provider.notifier).toggle(true);
            ref.read(checkBoxValue2Provider.notifier).toggle(false);
            ref.read(checkBoxValue3Provider.notifier).toggle(false);
          } else if (index == 1) {
            answerSelected = 1;
            ref.read(checkBoxValue1Provider.notifier).toggle(false);
            ref.read(checkBoxValue2Provider.notifier).toggle(true);
            ref.read(checkBoxValue3Provider.notifier).toggle(false);
          } else {
            answerSelected = 2;
            ref.read(checkBoxValue1Provider.notifier).toggle(false);
            ref.read(checkBoxValue2Provider.notifier).toggle(false);
            ref.read(checkBoxValue3Provider.notifier).toggle(true);
          }
        },
      ),
      Text(label)
    ]);
  }
}
