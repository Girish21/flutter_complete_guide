import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/expense_card.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:flutter_complete_guide/user_inputs.dart';
import 'package:uuid/uuid.dart';

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

  var userInput = {'title': '', 'amount': ''};

  void setField({String field, String value}) {
    setState(() {
      print({...userInput, field: value});
      userInput = {...userInput, field: value};
    });
  }

  void addTransaction() {
    setState(() {
      _transactions = [
        ..._transactions,
        Transaction(
          id: uuid.v4(),
          title: userInput['title'],
          spent: double.parse(userInput['amount']),
          date: DateTime.now(),
        ),
      ];
      userInput = {'title': '', 'amount': ''};
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
            onChange: setField,
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
