enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final Affordability affordability;
  final Complexity complexity;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;

  const Meal({
    this.id,
    this.categories,
    this.title,
    this.imageUrl,
    this.affordability,
    this.complexity,
    this.duration,
    this.ingredients,
    this.steps,
    this.isGlutenFree,
    this.isVegan,
    this.isVegetarian,
    this.isLactoseFree,
  });
}
