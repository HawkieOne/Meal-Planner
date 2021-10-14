import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meal_planner/widgets/DayWidget.dart';

/// This is the stateless widget that the main application instantiates.
class WeekWidget extends StatelessWidget {
  const WeekWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 7);
    final int rangeOfDays = 15;

    void onNextPressed() {
      controller.animateToPage(
          controller.page!.toInt() + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease);
    }

    void onPrevPressed() {
      controller.animateToPage(
          controller.page!.toInt() - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease);
    }

    List<String> getWeek() {
      DateTime now = DateTime.now().subtract(const Duration(days: 8));
      List<String> dates = <String>[];
      for (var i = 0; i < rangeOfDays; i++) {
        DateTime nextDay = now.add(const Duration(days: 1));
        String nextDayText = DateFormat('EEEE dd MMMM', 'en_US').format(nextDay);
        dates.add(nextDayText);
        now = nextDay;
      }
      return dates;
    }

    List<Widget> getAmountOfDays() {
      List<String> dates = getWeek();
      List<Widget> widgets = <Widget>[];
      for (int i = 0; i < rangeOfDays; i++) {
        Widget day = Center(
          child: DayWidget(dayTitle: dates[i],
            prevFunction: onPrevPressed, nextFunction: onNextPressed,),
        );
        widgets.add(day);
      }
      return widgets;
    }

    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: getAmountOfDays(),
    );
  }
}