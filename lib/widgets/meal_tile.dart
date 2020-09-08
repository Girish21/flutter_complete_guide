import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealTile extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final Affordability affordability;
  final Complexity complexity;
  final int duration;

  final Function clickHandler;

  const MealTile({
    Key key,
    @required this.clickHandler,
    @required this.imageUrl,
    @required this.title,
    @required this.id,
    @required this.affordability,
    @required this.complexity,
    @required this.duration,
  }) : super(key: key);

  String get complexityText {
    final map = {
      Complexity.Simple: 'Simple',
      Complexity.Challenging: 'Challenging',
      Complexity.Hard: 'Hard',
    };
    return map[complexity];
  }

  String get affordabilityText {
    final map = {
      Affordability.Affordable: 'Affordable',
      Affordability.Luxurious: 'Luxurious',
      Affordability.Pricey: 'Pricey',
    };
    return map[affordability];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => clickHandler(context, id),
      splashColor: Theme.of(context).primaryColorDark,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        elevation: 4,
        margin: EdgeInsets.all(
          8,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      16,
                    ),
                    topRight: Radius.circular(
                      16,
                    ),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 250,
                    color: Colors.black54,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('$duration min')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(affordabilityText)
                    ],
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
