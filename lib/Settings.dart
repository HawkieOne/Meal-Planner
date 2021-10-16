import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchValNot = true;
  bool switchValDark = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              LeftAlignedText(context, "Screen"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SettingsContainer(context, DarkModeSettings(context)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SettingsContainer(context, ColorBlindSettings(context)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              LeftAlignedText(context, "Meal"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              MultipleSettingsContainer(context, MealSettings(context)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              LeftAlignedText(context, "Statistics"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // const ScrollablePositionedListPage(),
            ],
          ),
        )
    );
  }

  Widget LeftAlignedText(dynamic context, String text) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        )
    );
  }

  Widget SwitchWidget(dynamic context, bool switchVal, ValueSetter<bool> func) {
    return Switch(
      activeColor: Theme
          .of(context)
          .primaryColorDark,
      onChanged: (bool value) {
        func(value);
      },
      value: switchVal,
    );
  }

  Widget SettingsContainer(dynamic context, Widget content) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: content
    );
  }

  Widget DarkModeSettings(dynamic context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Dark mode",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        SwitchWidget(context, switchValDark, (value) {
          setState(() {
            switchValDark = value;
          });
        }
        )
      ],
    );
  }

  Widget ColorBlindSettings(dynamic context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Color blind mode",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        SwitchWidget(context, switchValDark, (value) {
          setState(() {
            switchValDark = value;
          });
        }
        )
      ],
    );
  }

  Widget MultipleSettingsContainer(dynamic context, List<Widget> content) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: content,
        )
    );
  }

  List<Widget> MealSettings(dynamic context) {
    List<Widget> mealSettings = [
      BreakfastSetting(context),
    ];
    return mealSettings;
  }

  Widget BreakfastSetting(dynamic context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Breakfast",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.blue,
            width: 10,
            height: 10,
          ),
        )
      ],
    );
  }
}