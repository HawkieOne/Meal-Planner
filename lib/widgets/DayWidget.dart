import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_planner/widgets/DateInfo.dart';

import 'MealCell.dart';

/// This is the stateless widget that the main application instantiates.
class DayWidget extends StatelessWidget {
  final String dayTitle;
  const DayWidget({Key? key, this.dayTitle: "Undefined"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    String todayText = DateFormat('EEEE dd MMMM', 'en_US').format(today);

    final PageController controller = PageController(initialPage: 0);
    return SafeArea(
        child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  dateInfo(context, dayTitle),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20)),

                ],
                mealCell(context, "Breakfast", Theme.of(context).primaryColor),
                Divider(),
                mealCell(context, "Lunch", Theme.of(context).primaryColor),
                Divider(),
                mealCell(context, "Dinner", Theme.of(context).primaryColor),
              ),
            )
        ),
    );
  }
}