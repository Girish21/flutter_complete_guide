import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart({Key key, @required this.transactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );

      var amount = 0.0;

      this.transactions.forEach((element) {
        if (element.date.day == weekDay.day &&
            element.date.month == weekDay.month &&
            element.date.year == weekDay.year) {
          amount += element.spent;
        }
      });

      final day = DateFormat.E().format(weekDay).substring(0, 1);

      return {
        'day': day,
        'amount': amount,
      };
    });
  }

  double get totalAmount => transactions.fold(
      0.0, (previousValue, element) => previousValue + element.spent);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.2
          : MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: groupedTransactionValues
                .map(
                  (element) => ChartBar(
                    day: element['day'],
                    spendingAmount: (element['amount'] as double),
                    spendingPctOfTotal:
                        (element['amount'] as double) / totalAmount,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
