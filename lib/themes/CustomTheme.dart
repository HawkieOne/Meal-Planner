import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {

  static bool _isSpaceTheme = true;
  ThemeMode get currentTheme => _isSpaceTheme ? ThemeMode.dark : ThemeMode.light;

  // Toggles theme depending on if current theme is space
  void toggleTheme() {
    _isSpaceTheme = !_isSpaceTheme;
    notifyListeners();
  }

  // Medical Theme
  static ThemeData get nordTheme {
    return ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // Colors and brightness
        brightness: Brightness.dark,
        primaryColor: Color(0xff2E3440),
        scaffoldBackgroundColor: Color(0xff2E3440),
        primaryColorLight: Color(0xff434C5E),
        accentColor: Color(0xff5E81AC),
        highlightColor: Color(0xffA3BE8C),
        errorColor: Color(0xffBF616A),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xff5E81AC),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 10/* height / 80*/, horizontal: 20/*width / 15*/),
            textStyle: TextStyle(fontSize: 16.0, color: Color(0xffD8DEE9))
          )
        ),

        // Font family
        fontFamily: 'Georgia',

        // Text styles
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,  color: Color(0xffD8DEE9)),
          headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold,  color: Color(0xffD8DEE9)),
          headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,  color: Color(0xffD8DEE9)),
          headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal,  color: Color(0xff2E3440)),
          headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,  color: Color(0xffA3BE8C)),
          bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal,  color: Color(0xffD8DEE9)),
          bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,  color: Color(0xffD8DEE9)),
        ),
    );
  }
}