import 'package:cell_calendar/cell_calendar.dart';
import 'package:panchanga/panchanga_model.dart';
import 'package:panchanga/views/home.dart';
import 'package:panchanga/views/sample_event.dart';
import 'package:flutter/material.dart';

class CalendarData extends StatefulWidget {
  final List<Day> data;

  const CalendarData({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  State<CalendarData> createState() => _CalendarDataState();
}

class _CalendarDataState extends State<CalendarData> {
  @override
  Widget build(BuildContext context) {
    final cellCalendarPageController = CellCalendarPageController();
    var _sampleEvents = sampleEvents(widget.data);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 247, 206, 73),
      ),
      body: CellCalendar(
        todayMarkColor: Color.fromARGB(255, 255, 192, 2),
        // todayTextColor: Color.fromARGB(255, 30, 188, 59),
        cellCalendarPageController: cellCalendarPageController,
        events: _sampleEvents,
        daysOfTheWeekBuilder: (date) {
          final labels = ["S", "M", "T", "W", "T", "F", "S"];
          return Padding(
            // padding: const EdgeInsets.only(bottom: 1.0),
            // padding: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(0),
            child: Text(
              labels[date],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (date) {
          final year = date!.year.toString();
          final month = date.month.monthName;
          return Padding(
            // padding: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(0),
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
                ),
              ],
            ),
          );
        },
        // onCellTapped: (date) {
        // print('Its the date from calendar event $date');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => Panchanga(
        //             differenceDate: date,
        //           )),
        //   );
        // },
        onCellTapped: (date) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Panchanga(
                        differenceDate: date,
                      )));

          final eventsOnTheDate = _sampleEvents.where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == date.year &&
                eventDate.month == date.month &&
                eventDate.day == date.day;
          }).toList();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title:
                        Text(date.month.monthName + " " + date.day.toString()),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: eventsOnTheDate
                          .map(
                            (event) => Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.only(bottom: 12),
                              color: event.eventBackgroundColor,
                              child: Text(
                                event.eventName,
                                style: TextStyle(color: event.eventTextColor),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ));
        },
        onPageChanged: (firstDate, lastDate) {},
      ),
    );
  }
}
