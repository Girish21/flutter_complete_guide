import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/answer.dart';

class Question extends StatelessWidget {
  Question({Key key, this.questions, this.currentQuestion, this.nextQuestion})
      : super(key: key);

  final List<Map<String, Object>> questions;
  final int currentQuestion;
  final Function nextQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questions[currentQuestion]['question'],
            style: TextStyle(fontSize: 18),
          ),
          ...(questions[currentQuestion]['answers'] as List)
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
