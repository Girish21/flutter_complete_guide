import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/answer.dart';

class Question extends StatelessWidget {
  Question({Key key, this.questions, this.currentQuestion, this.nextQuestion})
      : super(key: key);

  final List<String> questions;
  final int currentQuestion;
  final Function nextQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(questions[currentQuestion]),
          ...['Answer 1', 'Answer 2']
              .map(
                (ans) => Answer(
                  answer: ans,
                  nextQuestion: nextQuestion,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
