import 'package:flutter/material.dart';

import './expense_card.dart';
import '../model/transaction.dart';

class Home extends StatelessWidget {
  final Function addTransaction;
  final List<Transaction> transactions;

  const Home({@required this.addTransaction, @required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ExpenseCard(
                      amount: transactions[index].spent.toStringAsFixed(2),
                      date: transactions[index].date,
                      title: transactions[index].title.toString(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
