import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './model/transaction.dart';
import './widgets/home.dart';
import './widgets/user_inputs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

var uuid = Uuid();

class _HomepageState extends State<Homepage> {
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

  void _addTransaction({String title, String amount}) {
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

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: UserInputs(
          addTransaction: _addTransaction,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expenses'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () => _showModal(context),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Home(
            addTransaction: _addTransaction,
            transactions: _transactions,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showModal(context),
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
