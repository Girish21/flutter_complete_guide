import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './expense_card.dart';
import './user_inputs.dart';
import '../model/transaction.dart';

var uuid = Uuid();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _transactions = [
    Transaction(
      id: uuid.v4(),
      title: 'Shirt',
      spent: 19.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: uuid.v4(),
      title: 'Watch',
      spent: 39.99,
      date: DateTime.now().add(
        Duration(days: -1),
      ),
    ),
  ];

  void addTransaction({String title, String amount}) {
    setState(() {
      _transactions = [
        ..._transactions,
        Transaction(
          id: uuid.v4(),
          title: title,
          spent: double.parse(amount),
          date: DateTime.now(),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Text(
                  'header charts',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          UserInputs(
            addTransaction: addTransaction,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (BuildContext context, int index) => ExpenseCard(
                    amount: _transactions[index].spent.toString(),
                    date: _transactions[index].date,
                    title: _transactions[index].title.toString(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
