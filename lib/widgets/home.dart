import 'package:flutter/material.dart';
import './chart.dart';

import './expense_card.dart';
import '../model/transaction.dart';

class Home extends StatelessWidget {
  final Function addTransaction;
  final Function deleteTransaction;
  final List<Transaction> transactions;

  List<Transaction> get recentTransactions {
    return transactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(
                days: 7,
              ),
            ),
          ),
        )
        .toList();
  }

  const Home({
    @required this.addTransaction,
    @required this.transactions,
    @required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (transactions.length > 0)
              Chart(
                transactions: this.recentTransactions,
              ),
            if (transactions.length > 0)
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
                        deleteTransaction: deleteTransaction,
                        id: transactions[index].id,
                      ),
                    ),
                  ),
                ),
              ),
            if (transactions.length == 0)
              Column(
                children: [
                  Text(
                    'No Transaction added yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Image.asset(
                    'assets/images/waiting.png',
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
