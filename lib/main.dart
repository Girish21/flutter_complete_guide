import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<String> questions = [
    'What\'s your favorite color?',
    'What\'s your favorite animal?'
  ];

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('My First App'),
        ),
        body: Row(
          children: [
            Column(
              children: questions
                  .map(
                    (question) => Column(
                      children: [
                        Text(question),
                        ...['Answer 1', 'Answer 2']
                            .map(
                              (ans) => RaisedButton(
                                child: Text(ans),
                                onPressed: () => print(ans),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    ));
  }
}
