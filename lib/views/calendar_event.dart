import 'package:cell_calendar/cell_calendar.dart';
import 'package:panchanga/panchanga_model.dart';
import 'package:panchanga/views/sample_event.dart';
import 'package:flutter/material.dart';
import 'home.dart';

// ignore: must_be_immutable
class CalendarDisplay extends StatefulWidget {
  CalendarDisplay({required this.title});

  final String title;

  @override
  State<CalendarDisplay> createState() => _CalendarDisplayState();
}

class _CalendarDisplayState extends State<CalendarDisplay> {
  List<Day> panchangaCalendarDataList = <Day>[];

  @override
  Widget build(BuildContext context) {
    // final _calendarPanchanagaDAtes = Panchanga();
    // _calendarPanchanagaDAtes;
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 247, 206, 73),
      ),
      body: CellCalendar(
        // todayMarkColor: Color.fromARGB(255, 255, 192, 2),
        cellCalendarPageController: cellCalendarPageController,
        events: _sampleEvents,
        daysOfTheWeekBuilder: (example) {
          final labels = ["S", "M", "T", "W", "T", "F", "S"];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[example],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime!.year.toString();
          final month = datetime.month.monthName;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "$month  $year",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    cellCalendarPageController.animateToDate(
                      DateTime.now(),
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 300),
                    );
                  },
                )
              ],
            ),
          );
        },
        onCellTapped: (date) {
          // Scrollable.ensureVisible(ContextAction());
          final newYear = DateTime(2022, 01, 01);
          final difference = date.difference(newYear).inDays;
          print('Its the date from calendar event $difference');

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Panchanga(
                    // differenceDate: difference,
                    )),
          );
        },
        onPageChanged: (firstDate, lastDate) {
          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
        },
      ),
    );
  }
}
