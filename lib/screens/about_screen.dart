import 'package:flutter/material.dart';

List<String> categories = [
  "Math",
  "History",
  "Geography",
  "Science",
];

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Padding(padding: EdgeInsets.all(8.0), child: Text("Trivia Game V1.0")),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Is it a game or is it an app whatever.\nIt asks you questions and if you get it right it going to add 20 points to the points counter.\nIf you have answered all the questions correctly or not, It's going to take you to the end game screen and show you your points and how many questions you answered correctly")),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Features to be implemented:\n1. Sounds i.e Correct answer or wrong answer")),
        Padding(
            padding: EdgeInsets.all(8.0), child: Text("List of categories:")),
        Padding(padding: EdgeInsets.all(8.0), child: CategoryList())
      ]),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((category) => Text(category)).toList());
  }
}
