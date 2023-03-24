import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckBoxValueNotifier extends StateNotifier<bool> {
  CheckBoxValueNotifier({required bool value}) : super(value);

  void toggle(bool value) {
    state = value;
  }
}

class QuestionNumberNotifier extends StateNotifier<int> {
  QuestionNumberNotifier({required int number}) : super(number);

  void increment() {
    state++;
  }

  void reset() {
    state = 0;
  }
}

class PointsNotifier extends StateNotifier<int> {
  PointsNotifier({required int number}) : super(number);

  void increase(int number) {
    state += number;
  }

  void reset() {
    state = 0;
  }
}
