import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/quiz.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('My First App'),
        ),
        body: MySimpleQuiz(),
      ),
    ));
  }
}
