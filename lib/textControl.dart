import 'package:flutter/material.dart';

class TextControl extends StatefulWidget {
  @override
  _TextControlState createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  var _textToDisplay = 'Init Text';

  void _clickHandler() {
    setState(() {
      _textToDisplay = _textToDisplay == 'Button Clicked' ? 'Init Text' : 'Button Clicked';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _textToDisplay,
          ),
          SizedBox(
            height: 32,
          ),
          RaisedButton(
            onPressed: _clickHandler,
            child: Text(
              'Click me!',
            ),
            color: Colors.blue,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
