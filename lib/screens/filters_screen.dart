import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class Filters extends StatelessWidget {
  static const FiltersRoute = '/filters';

  const Filters({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
        ),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Filters',
        ),
      ),
    );
  }
}
