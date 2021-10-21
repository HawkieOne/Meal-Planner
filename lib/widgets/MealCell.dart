import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/models/MealModel.dart';
import 'package:provider/provider.dart';

Widget mealCell(dynamic context, String mealTime, Color backgroundColor, IconData icon) {
  return
    ChangeNotifierProvider(
      create: (context) => MealModel(),
      child: Expanded(
          child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    mealTime,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Consumer<MealModel>(
                    builder: (context, meal, child) {
                      return Row(
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
                                "Chosen meal: ${meal.meal}",

                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/mealInfo',
                                      arguments: {'title': mealTime});
                                },
                                child: Text(
                                    "Change meal"
                                ),
                              ),
                            ],
                          ),
                         Icon(
                           icon,
                           size: 60,
                         ),
                        ],
                      );
                    },
                  ),
                ],
              )
          )
      )
    );
}