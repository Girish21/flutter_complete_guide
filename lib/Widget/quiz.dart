import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/question.dart';

class MySimpleQuiz extends StatefulWidget {
  MySimpleQuiz({Key key}) : super(key: key);

  @override
  _MySimpleQuizState createState() => _MySimpleQuizState();
}

class _MySimpleQuizState extends State<MySimpleQuiz> {
  final _questions = [
    'What\'s your favorite color?',
    'What\'s your favorite animal?'
  ];

  var _currentQuestion = 0;

  void _nextQuestion() {
    setState(() {
      if (_currentQuestion == 1)
        _currentQuestion = 0;
      else
        _currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Question(
            currentQuestion: _currentQuestion,
            nextQuestion: _nextQuestion,
            questions: _questions,
          )
        ],
      ),
    );
  }
}
