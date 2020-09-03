import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:strings/strings.dart';

class ExpenseCard extends StatelessWidget {
  final String amount;
  final String title;
  final DateTime date;

  ExpenseCard({Key key, this.amount, this.title, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          maxRadius: 22,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              '\$$amount',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        title: Text(
          capitalize(title),
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          DateFormat('MMM d, y').format(date).toString(),
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
