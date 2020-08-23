import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  Answer({Key key, this.answer, this.nextQuestion}) : super(key: key);

  final String answer;
  final Function nextQuestion;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(answer),
      onPressed: () {
        print(answer);
        nextQuestion();
      },
    );
  }
}
