import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text(
                    "test -1 A longg text",
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    "test - 2",
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Text("test - 2"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
