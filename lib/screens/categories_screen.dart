import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_tile.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final medai = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: GridView.builder(
        itemCount: DUMMY_CATEGORIES.length,
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: medai.size.width * 0.05,
          mainAxisSpacing: medai.orientation == Orientation.portrait
              ? medai.size.height * 0.02
              : medai.size.height * 0.05,
        ),
        itemBuilder: (context, index) => CategoryTile(
          color: DUMMY_CATEGORIES[index].color,
          title: DUMMY_CATEGORIES[index].title,
          id: DUMMY_CATEGORIES[index].id,
        ),
      ),
    );
  }
}
