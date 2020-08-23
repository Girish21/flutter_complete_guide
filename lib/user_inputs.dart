import 'package:flutter/material.dart';

class UserInputs extends StatefulWidget {
  @override
  _UserInputsState createState() => _UserInputsState();
}

class _UserInputsState extends State<UserInputs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
