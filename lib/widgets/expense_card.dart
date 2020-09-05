import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:strings/strings.dart';

class ExpenseCard extends StatelessWidget {
  final String amount;
  final String title;
  final String id;
  final DateTime date;
  final Function deleteTransaction;

  ExpenseCard({
    Key key,
    @required this.amount,
    @required this.title,
    @required this.date,
    @required this.id,
    @required this.deleteTransaction,
  }) : super(key: key);

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
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => deleteTransaction(id: id),
        ),
      ),
    );
  }
}
