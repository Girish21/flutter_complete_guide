import 'package:flutter/material.dart';

class UserInputs extends StatelessWidget {
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
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Add Transaction',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
