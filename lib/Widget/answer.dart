import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class Answer extends StatelessWidget {
  Answer({Key key, this.answer, this.nextQuestion}) : super(key: key);

  final String answer;
  final Function nextQuestion;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(capitalize(answer)),
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () {
        print(answer);
        nextQuestion();
      },
    );
  }
}
