import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final Color color;

  const CategoryTile({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.7),
            color,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
    );
  }
}
