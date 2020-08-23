import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final String amount;
  final String title;
  final String date;

  ExpenseCard({Key key, this.amount, this.title, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Card(
      child: Container(
        height: 50,
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
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                  ),
                  Text(
                    date,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
