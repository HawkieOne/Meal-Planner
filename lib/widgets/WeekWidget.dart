import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meal_planner/widgets/DayWidget.dart';

/// This is the stateless widget that the main application instantiates.
class WeekWidget extends StatelessWidget {
  const WeekWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 6);

    void onNextPressed() {
      controller.animateToPage(
          controller.page!.toInt() + 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn);
    }

    void onPrevPressed() {
      controller.animateToPage(
          controller.page!.toInt() + 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn);
    }

    List<String> getWeek() {
      DateTime now = DateTime.now();
      List<String> dates = <String>[];
      for (var i = 6; i > 0; i--) {
        DateTime prevDay = now.subtract(Duration(days: i));
        String prevDayText = DateFormat('EEEE dd MMMM', 'en_US').format(prevDay);
        dates.add(prevDayText);
      }
      String todayText = DateFormat('EEEE dd MMMM', 'en_US').format(now);
      dates.add(todayText);
      for (var i = 0; i < 6; i++) {
        DateTime nextDay = now.add(Duration(days: i));
        String nextDayText = DateFormat('EEEE dd MMMM', 'en_US').format(nextDay);
        dates.add(nextDayText);
      }
      return dates;
    }

    List<Widget> getAmountOfDays() {
      List<String> dates = getWeek();
      List<Widget> widgets = <Widget>[];
      for (int i = 0; i < 13; i++) {
        Widget day = Center(
          child: DayWidget(dayTitle: dates[i]),
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