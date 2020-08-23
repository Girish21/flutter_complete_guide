import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class Result extends StatelessWidget {
  Result({Key key, @required this.resetQuiz}) : super(key: key);

  final Function resetQuiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You have reached the end',
          style: TextStyle(fontSize: 28),
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
