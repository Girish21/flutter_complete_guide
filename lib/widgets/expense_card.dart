import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String amount;
  final String title;
  final DateTime date;

  ExpenseCard({Key key, this.amount, this.title, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 84,
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            CircleAvatar(
              maxRadius: 22,
              child: Text(
                '\$$amount',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
                ),
              ),
              backgroundColor: Theme.of(context).accentColor,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    new DateFormat('MMM d, y').format(date).toString(),
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
