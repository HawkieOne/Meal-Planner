import 'package:flutter/material.dart';
import 'package:meal_planner/themes/CustomTheme.dart';
import 'package:meal_planner/widgets/WeekWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mealeon',
      theme: CustomTheme.nordTheme,
      home: MyHomePage(title: 'Mealeon'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: WeekWidget()
    );
  }
}
