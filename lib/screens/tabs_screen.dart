import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/favorites_screen.dart';

import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tabs',
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Categories',
                ),
                icon: Icon(
                  Icons.category,
                ),
              ),
              Tab(
                child: Text(
                  'Favorites',
                ),
                icon: Icon(
                  Icons.star,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Categories(),
            Favorites(),
          ],
        ),
      ),
    );
  }
}
