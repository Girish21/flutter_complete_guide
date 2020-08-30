import 'package:flutter/material.dart';

class UserInputs extends StatelessWidget {
  final Function onChange;
  final Function addTransaction;
  const UserInputs({@required this.onChange, @required this.addTransaction});

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
                onChanged: (value) => onChange(field: 'title', value: value),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                onChanged: (value) => onChange(field: 'amount', value: value),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: addTransaction,
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
