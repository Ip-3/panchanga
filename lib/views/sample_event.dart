import 'dart:io';
import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:panchanga/panchanga_model.dart';
import 'dart:core';
import 'dart:convert' as convert;

import 'package:path_provider/path_provider.dart';

List<CalendarEvent> sampleEvents(List<Day> calendarmappingList) {
  print(
      'The calendarmappingList length is ,,,,,,,,${calendarmappingList.length}');

  List<String> calendarMark = calendarmappingList
      .map((panchanagaSearch) => (panchanagaSearch.calendarmark))
      .toList();
  List<String> calendarPaksha = calendarmappingList
      .map((panchanagaSearch) => (panchanagaSearch.paksha))
      .toList();
  List<String> calendarThithi = calendarmappingList
      .map((panchanagaSearch) => (panchanagaSearch.tithi))
      .toList();

  List<String> calendarDataDate = calendarmappingList
      .map((panchanagaSearch) => (panchanagaSearch.date))
      .toList();
  List<String> calendarDataMonth = calendarmappingList
      .map((panchanagaSearch) => (panchanagaSearch.month))
      .toList();
  List<String> calendarDataYear = calendarmappingList
      .map((panchanagaSearch) => (panchanagaSearch.year))
      .toList();

  print('The length is ,,,,,,,,${calendarThithi.length}');

  List<int> intcalendarDataDate = calendarDataDate.map(int.parse).toList();
  List<int> intcalendarDataMonth = calendarDataMonth.map(int.parse).toList();
  List<int> intcalendarDataYear = calendarDataYear.map(int.parse).toList();

  final int initialYear = intcalendarDataYear[0];
  final int initialMonth = intcalendarDataMonth[0];
  final int initialDate = intcalendarDataDate[0];
  print(
      'Indexxxx Date is :: ${intcalendarDataDate[0]}/${intcalendarDataMonth[0]}/${intcalendarDataYear[0]}');

  print('Initial Date is :: $initialDate/$initialMonth/$initialYear');

  final startDay = DateTime(initialYear, initialMonth, initialDate);
  print(startDay);
  // final startDay = DateTime(2022, 03, 03);
  // final startDay = DateTime.now();
  // final endDay = DateTime(2099, 12, 30);
  var i = 0;
  // var count = 0;
  // List<String> aaa = ['a', 'b', 'c', 'd'];
  // print('The length is ,,,,,,,,${calendarData.length}');

  final sampleEvents = [
    for (i = 0; i < calendarThithi.length; i++)
      // if (aaa[i] == 'a')
      CalendarEvent(
          eventName: calendarThithi[i],
          eventDate: startDay.add(Duration(days: i)),
          eventBackgroundColor: Colors.white,
          eventTextColor: Color.fromARGB(255, 254, 48, 20)),
    // for (i = 0; i < calendarThithi.length; i++)
    //   if (calendarThithi[i] == 'Amavasya')
    //     CalendarEvent(
    //         eventName: calendarThithi[i],
    //         eventDate: startDay.add(Duration(days: i)),
    //         eventBackgroundColor: Colors.white,
    //         eventTextColor: Color.fromARGB(255, 0, 0, 0)),
    // for (i = 0; i < calendarThithi.length; i++)
    //   if (calendarThithi[i] == 'Pournima')
    //     CalendarEvent(
    //         eventName: calendarThithi[i],
    //         eventDate: startDay.add(Duration(days: i)),
    //         eventBackgroundColor: Colors.white,
    //         eventTextColor: Color.fromARGB(255, 8, 112, 232)),
    for (i = 0; i < calendarPaksha.length; i++)
      // if (aaa[i] == 'a')
      CalendarEvent(
          eventName: calendarPaksha[i],
          eventDate: startDay.add(Duration(days: i)),
          eventBackgroundColor: Colors.white,
          eventTextColor: Color.fromARGB(255, 198, 159, 4)),
  ];
  return sampleEvents;
}
