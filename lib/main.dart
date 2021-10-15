import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_planner/Settings.dart';
import 'package:meal_planner/themes/CustomTheme.dart';
import 'package:meal_planner/widgets/CustomAppBar.dart';
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
      initialRoute: '/',
      routes: {
        '/home': (context) => HomePage(title: "Mealeon"),
        '/settings': (context) => const Settings(),
        // '/statistics':
      },
      home: HomePage(title: 'Mealeon'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState()
  {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: "Mealeon"),
      body: WeekWidget()
    );
  }
}
