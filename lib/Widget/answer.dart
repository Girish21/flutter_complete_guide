import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class Answer extends StatelessWidget {
  Answer({Key key, @required this.answer, @required this.nextQuestion})
      : super(key: key);

  final Map<String, Object> answer;
  final Function nextQuestion;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(capitalize(answer['text'])),
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () {
        print(answer);
        nextQuestion(answer['score']);
      },
    );
  }
}
