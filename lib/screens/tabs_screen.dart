import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favorites;

  const TabsScreen({
    Key key,
    @required this.favorites,
  }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  PageController _controller;
  int _selecteedPageIndex = 0;
  final List<String> _pageTitles = ['Categories', 'Your Favorites'];

  void initState() {
    super.initState();
    _controller = new PageController(
      initialPage: _selecteedPageIndex,
    );
  }

  void _selectPage(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitles[_selecteedPageIndex],
        ),
      ),
      drawer: MainDrawer(),
      body: PageView(
        controller: _controller,
        onPageChanged: (newPage) {
          setState(() {
            _selecteedPageIndex = newPage;
          });
        },
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Categories(),
          Favorites(
            favorites: widget.favorites,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selecteedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            title: Text(
              'Categories',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            title: Text(
              'Favorites',
            ),
          ),
        ],
      ),
    );
  }
}
