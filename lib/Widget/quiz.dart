import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/question.dart';
import 'package:flutter_complete_guide/Widget/result.dart';

class MySimpleQuiz extends StatefulWidget {
  MySimpleQuiz({Key key}) : super(key: key);

  @override
  _MySimpleQuizState createState() => _MySimpleQuizState();
}

class _MySimpleQuizState extends State<MySimpleQuiz> {
  final _questions = const [
    {
      "question": "What's your favorite color?",
      "answers": [
        {'text': 'red', 'score': 5},
        {'text': 'blue', 'score': 1},
        {'text': 'black', 'score': 10}
      ]
    },
    {
      "question": "What's your favorite animal?",
      "answers": [
        {'text': 'dog', 'score': 1},
        {'text': 'cat', 'score': 1},
        {'text': 'lion', 'score': 6},
        {'text': 'snake', 'score': 10}
      ]
    },
    {
      "question": "Who's your favorite instructor?",
      "answers": [
        {'text': 'max', 'score': 1},
        {'text': 'max', 'score': 1}
      ]
    }
  ];

  var _currentQuestion = 0;
  var _score = 0;

  void _nextQuestion(score) {
    setState(() {
      _score += score;
      if (_currentQuestion == _questions.length)
        _currentQuestion = 0;
      else
        _currentQuestion++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestion = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      width: double.infinity,
      child: _currentQuestion == _questions.length
          ? Result(
              score: _score,
              resetQuiz: _resetQuiz,
            )
          : Question(
              currentQuestion: _currentQuestion,
              nextQuestion: _nextQuestion,
              questions: _questions,
            ),
    );
  }
}
