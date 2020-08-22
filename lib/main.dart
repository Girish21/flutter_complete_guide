import 'package:flutter/material.dart';

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

class MySimpleQuiz extends StatefulWidget {
  MySimpleQuiz({Key key}) : super(key: key);

  @override
  _MySimpleQuizState createState() => _MySimpleQuizState();
}

class _MySimpleQuizState extends State<MySimpleQuiz> {
  final questions = [
    'What\'s your favorite color?',
    'What\'s your favorite animal?'
  ];

  var _currentQuestion = 0;

  void _nextQuestion() {
    setState(() {
      if (_currentQuestion == 1) _currentQuestion = 0;
      else _currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(questions[_currentQuestion]),
              ...['Answer 1', 'Answer 2']
                  .map(
                    (ans) => RaisedButton(
                      child: Text(ans),
                      onPressed: () {
                        print(ans);
                        _nextQuestion();
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
