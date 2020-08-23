import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/question.dart';

class MySimpleQuiz extends StatefulWidget {
  MySimpleQuiz({Key key}) : super(key: key);

  @override
  _MySimpleQuizState createState() => _MySimpleQuizState();
}

class _MySimpleQuizState extends State<MySimpleQuiz> {
  final _questions = const [
    {
      "question": "What's your favorite color?",
      "answers": ['red', 'blue', 'black']
    },
    {
      "question": "What's your favorite animal?",
      "answers": ['dog', 'cat', 'lion']
    },
    {
      "question": "Who's your favorite instructor?",
      "answers": ['max', 'max']
    }
  ];

  var _currentQuestion = 0;

  void _nextQuestion() {
    setState(() {
      if (_currentQuestion == _questions.length - 1)
        _currentQuestion = 0;
      else
        _currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Question(
          currentQuestion: _currentQuestion,
          nextQuestion: _nextQuestion,
          questions: _questions,
        )
      ],
    );
  }
}
