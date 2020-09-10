import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildTile(Icon icon, String text, Function taphandler) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: taphandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(
              8,
            ),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          buildTile(
            Icon(
              Icons.restaurant,
              size: 24,
            ),
            'Meals',
            () => Navigator.of(context).pushReplacementNamed(
              '/',
            ),
          ),
          buildTile(
            Icon(
              Icons.settings,
              size: 24,
            ),
            'Filters',
            () => Navigator.of(context).pushReplacementNamed(
              Filters.FiltersRoute,
            ),
          ),
        ],
      ),
    );
  }
}
