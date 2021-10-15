
import 'package:flutter/foundation.dart';

class MealModel extends ChangeNotifier {

  /// List of items in the cart.
  String meal = "";
  Map recipe = Map<String, int>();
  String note = "";

  /// Add [amount] of [ingredient] to a meal
  void addIngredient(String ingredient, int amount) {
    recipe[ingredient] = amount;
    notifyListeners();
  }

  void setMeal(String meal) {
    this.meal = meal;
    notifyListeners();
  }

  void setNote(String note) {
    this.note = note;
    notifyListeners();
  }


  void removeIngredient(String ingredient) {
    recipe.remove(ingredient);
    notifyListeners();
  }
}