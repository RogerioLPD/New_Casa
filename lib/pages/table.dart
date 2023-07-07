import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nucleo/components/components.dart';
import 'package:nucleo/kpadding.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: kIsWeb ? kPadding : 0),
        child: Column(
          children: [
            const MenuBar1(),
            TableCalendar(focusedDay: now, firstDay: firstDay, lastDay: lastDay)
          ],
        ),
      ),
    );
  }
}
