import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/widgets/Popup.dart';

Widget mealCell(dynamic context, String mealTime, Color backgroundColor) {
  return Expanded(
      child: Container(
        child: Column(
          children: [
            Text(
              mealTime,
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Meal",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "Chosen meal",

                    ),
                    ElevatedButton(
                      onPressed: () => {
                        Popup(context: context).show(),
                        print("TEST"),
                      },
                      child: Text(
                          "Change meal"
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => {

                      },
                      child: Text(
                          "Add recipes"
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {

                      },
                      child: Text(
                          "Add note"
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      )
  );
}