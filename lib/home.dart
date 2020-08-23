import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/transaction.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _transactions = [
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
          Expanded(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (BuildContext context, int index) => Card(
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
                              '\$' + _transactions[index].spent.toString(),
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
                                  _transactions[index].title,
                                ),
                                Text(
                                  _transactions[index].date.toString(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
