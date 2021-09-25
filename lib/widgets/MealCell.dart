import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget mealCell(dynamic context, String meal, Color backgroundColor) {
  return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor
        ),
        child: Column(
          children: [
            Text(
              meal,
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