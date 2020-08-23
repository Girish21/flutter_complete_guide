import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class Result extends StatelessWidget {
  Result({Key key, @required this.resetQuiz, @required this.score})
      : super(key: key);

  final Function resetQuiz;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'The score of the quiz is',
          style: TextStyle(fontSize: 28),
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          '$score',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          height: 64,
        ),
        RaisedButton(
          child: Text(capitalize('reset')),
          color: Colors.blue,
          onPressed: resetQuiz,
          textColor: Colors.white,
        )
      ],
    );
  }
}
