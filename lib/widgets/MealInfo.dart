import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MealInfo extends StatefulWidget {
  final String title;

  MealInfo({Key? key, this.title: "Undefined"}) : super(key: key);

  @override
  _MealInfoState createState() => _MealInfoState();
}

class _MealInfoState extends State<MealInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BackButton(),
              Text(
                "Testing",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
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
                // TextField(style: TextStyle(color: Colors.white)),
                ],
              ),
              Icon(
                Icons.dinner_dining,
                size: 60,
              )
            ],
          )
        ],
      )
    );
  }
}