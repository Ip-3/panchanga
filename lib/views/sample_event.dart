import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  final sampleEvents = [
    CalendarEvent(
        eventName: "Project Completion",
        eventDate: today.add(Duration(days: 2)),
        eventBackgroundColor: Colors.black),
  ];
  return sampleEvents;
}
