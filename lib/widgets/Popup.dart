import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/widgets/PopupWidgets.dart';
import 'package:meal_planner/models/MealModel.dart';

class Popup {
  final BuildContext context;
  MealModel meal;
  final bool crossButton;
  // ignore: non_constant_identifier_names
  final bool cross_button_right;
  final double message_to_button_gap;

  TextEditingController mealController = TextEditingController();
  TextEditingController recipeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  Popup({
    Key? key,
    required this.context,
    required this.meal,
    this.crossButton = true,
    this.cross_button_right = true,
    this.message_to_button_gap = 18.0,
  });

  Future show() => showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(dialogBackgroundColor: Color(0xff2E3440)),
          child: AlertDialog(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Center(
                      child: new Text(
                        "Add a meal",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    crossButton
                        ? Positioned(
                      right: 0,
                      child: Align(
                        alignment: cross_button_right
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: InkWell(
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).errorColor,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                        : Container(),
                    crossButton
                        ? SizedBox(
                      height: 20,
                      width: 8,
                    )
                        : Container(),
                  ],
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextCaption(context, "Meal"),
                  TextField(controller: mealController),
                  // TextInput(context),
                  SizedBox(height: 10),
                  TextCaption(context, "Recipes"),
                  TextField(controller: recipeController),
                  // TextInput(context),
                  SizedBox(height: 10,),
                  TextCaption(context, "Notes"),
                  TextField(controller: noteController),
                  // TextInput(context),
                  SizedBox(height: 20,),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      meal.setMeal(mealController.text);
                      meal.setNote(noteController.text);
                      Navigator.pop(context);
                    },
                    backgroundColor: Theme.of(context).highlightColor,
                    label: Text(
                      "Save",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
