// import 'dart:ffi';
import 'dart:async';
// import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panchanga/panchanga_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:path_provider/path_provider.dart';
// import 'package:dio/dio.dart';

// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';

class Panchanga extends StatefulWidget {
  @override
  _PanchangaState createState() => _PanchangaState();
}

class _PanchangaState extends State<Panchanga> {
  final Future<Widget> displayDesignWidget = Future<Widget>.delayed(
    const Duration(seconds: 5),
    () => DisplayDesign(
        ayana: '',
        karana: '',
        date: '',
        calendarmark: '',
        masa: '',
        masaniyamaka: '',
        month: '',
        rutu: '',
        nakshatra: '',
        paksha: '',
        sunrise: '',
        samvatsara: '',
        shradhatithi: '',
        tithi: '',
        vasara: '',
        year: '',
        vishesha: '',
        yoga: '',
        sunset: ''),
  );

  var output;
  var langValue;
  var updatelanguage;

  Future<String?> get localPathEnglish async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  var path;
  Future<File> get localEnglishFile async {
    path = await localPathEnglish;
    print(path);
    return new File('$path/EnglishLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateEnglishFile async {
    path = await localPathEnglish;
    print(path);
    return new File('$path/updatedDataEnglish.json').create(recursive: true);
  }

  Future<String> get localPathKannada async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localKannadaFile async {
    path = await localPathKannada;
    print(path);
    return new File('$path/KannadaLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateKannadaFile async {
    path = await localPathKannada;
    print(path);
    return new File('$path/updatedDataKannada.json').create(recursive: true);
  }

  Future<String> get localPathHindi async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localHindiFile async {
    path = await localPathHindi;
    print(path);
    return new File('$path/HindiLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateHindiFile async {
    path = await localPathHindi;
    print(path);
    return new File('$path/updatedDataHindi.json').create(recursive: true);
  }

  Future<String> get localPathTamil async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localTamilFile async {
    path = await localPathTamil;
    print(path);
    return new File('$path/TamilLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateTamilFile async {
    path = await localPathTamil;
    print(path);
    return new File('$path/updatedDataTamil.json').create(recursive: true);
  }

  Future<String> get localPathTelugu async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localTeluguFile async {
    path = await localPathTelugu;
    print(path);
    return new File('$path/TeluguLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateTeluguFile async {
    path = await localPathTelugu;
    print(path);
    return new File('$path/updatedDataTelugu.json').create(recursive: true);
  }

  Future<String> get localPathSanskrit async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localSanskritFile async {
    path = await localPathSanskrit;
    print(path);
    return new File('$path/SanskritLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateSanskritFile async {
    path = await localPathSanskrit;
    print(path);
    return new File('$path/updatedDataSanskrit.json').create(recursive: true);
  }

  List<Day> panchangalistmodel = <Day>[];
  List<Day> panchangalistmodelUpdate = <Day>[];

  var appScriptURLEnglish =
      'https://script.google.com/macros/s/AKfycbxIQNJzrGKgbhuu7fJ0pv6UpRbIQEG8Qz21Zgv0rJkxEUzft0ktmhB9f0Ql4zCqTrbZMA/exec';
  var appScriptURLKannada =
      "https://script.google.com/macros/s/AKfycbzawpXN_Um-dns-ffHWNyXdYf7x4W7jxafpzQdeOkJradsK6wWlwR3lIykk-GHr9_bA/exec";
  var appScriptURLTelugu =
      "https://script.google.com/macros/s/AKfycby6oDkxpT-dqMqteMHMbNkIpB4KNda06bDEJsejZks-FN-jmnwSDQ9ZJOF2nhVEroAY/exec";
  var appScriptURLTamil =
      "https://script.google.com/macros/s/AKfycbzcjH5hPG5FR-mP5BiPIFxcSg_1-G2YTJz9rQlYxrxhqFOptVkMvj-dJPS_PUeJiwqZdA/exec";
  var appScriptURLSanskrit =
      "https://script.google.com/macros/s/AKfycbzqBvKyCknqlItNuVzzNxF6h6cRUiJnNBByqFEbdHyLpv1NmfccDDIyru2mBRP0EhYbyQ/exec";
  var appScriptURLHindi =
      "https://script.google.com/macros/s/AKfycbyebmCB2xv6KWRnQHUZAS3JeJxoe8jWkvePx2o601T18RovlwJnlV69M6D-0w5mn8J-/exec";
  var jsonPanchanga;
  File? myUpdatedfile;

  getEnglishPanchanga() async {
    File? myfile;
    File? myUpdatedfile;
    myfile = await localEnglishFile;
    // await Future.delayed(Duration(seconds: 2));
    myUpdatedfile = await localUpdateEnglishFile;
    String? contents = await myfile.readAsString();
    print(contents);
    print("Inside English Panchanga");
    if (contents.isEmpty == true) {
      print("Inside English Panchanga If");
      var raw = await http.get(Uri.parse(appScriptURLEnglish));
      // var raw = await http.get(Uri.parse(appScriptURLEnglish));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });

      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      print("Inside English Panchanga else");
      var raw = await rootBundle.loadString('$path/EnglishLanguage.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
    if (updatelanguage == true) {
      print("Inside English Panchanga Update If");
      var request = appScriptURLEnglish + "?aaa=hit";
      // var request = Uri.parse(appScriptURLEnglish).queryParameters["aaa"];
      print(request);
      // if (request != null) {
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      print(myUpdatedfile.writeAsString(jsondata));
      myUpdatedfile.writeAsString(jsondata);
      // getUpdateDayObject();
      String? compare2 = await myUpdatedfile.readAsString();
      var comparejson2 = convert.jsonDecode(compare2);
      comparejson2.forEach((element) {
        // print('Default English Panchanga List');
        // print(element);
        Day day = new Day(
            ayana: '',
            karana: '',
            date: '',
            calendarmark: '',
            masa: '',
            masaniyamaka: '',
            month: '',
            rutu: '',
            nakshatra: '',
            paksha: '',
            sunrise: '',
            samvatsara: '',
            shradhatithi: '',
            tithi: '',
            vasara: '',
            year: '',
            vishesha: '',
            yoga: '',
            sunset: '');
        day.date = element['date'].toString();
        day.month = element['month'].toString();
        day.year = element['year'].toString();
        day.samvatsara = element['samvatsara'].toString();
        day.ayana = element["ayana"].toString();
        day.paksha = element["paksha"].toString();
        day.rutu = element['rutu'].toString();
        day.masa = element['masa'].toString();
        day.masaniyamaka = element['masaniyamaka'].toString();
        day.calendarmark = element['calendarmark'].toString();
        day.vasara = element["vasara"].toString();
        day.nakshatra = element['nakshatra'].toString();
        day.tithi = element['tithi'].toString();
        day.yoga = element['yoga'].toString();
        day.karana = element['karana'].toString();
        day.sunrise = element['sunrise'].toString();
        day.sunset = element["sunset"].toString();
        day.shradhatithi = element['shradhatithi'].toString();
        day.vishesha = element['vishesha'].toString();
        panchangalistmodelUpdate.add(day);
      });
      getUpdateCompare();

      // }

    } else {
      print("Inside English Panchanga Update else");
      var raw = await rootBundle.loadString('$path/updatedDataEnglish.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getKannadaPanchanga() async {
    File? myfile;
    File? myUpdatedfile;
    myfile = await localKannadaFile;
    // await Future.delayed(Duration(seconds: 2));
    myUpdatedfile = await localUpdateKannadaFile;
    String? contents = await myfile.readAsString();
    print(contents);
    print("Inside Kannada Panchanga");
    if (contents.isEmpty == true) {
      print("Inside Kannada Panchanga If");
      var raw = await http.get(Uri.parse(appScriptURLKannada));
      // var raw = await http.get(Uri.parse(appScriptURLEnglish));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });

      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      print("Inside Kannada Panchanga else");
      var raw = await rootBundle.loadString('$path/KannadaLanguage.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
    if (updatelanguage == true) {
      print("Inside Kannada Panchanga Update If");
      var request = appScriptURLKannada + "?aaa=hit";
      // var request = Uri.parse(appScriptURLEnglish).queryParameters["aaa"];
      print(request);
      // if (request != null) {
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      print(myUpdatedfile.writeAsString(jsondata));
      myUpdatedfile.writeAsString(jsondata);
      // getUpdateDayObject();
      String? compare2 = await myUpdatedfile.readAsString();
      var comparejson2 = convert.jsonDecode(compare2);
      comparejson2.forEach((element) {
        // print('Default English Panchanga List');
        // print(element);
        Day day = new Day(
            ayana: '',
            karana: '',
            date: '',
            calendarmark: '',
            masa: '',
            masaniyamaka: '',
            month: '',
            rutu: '',
            nakshatra: '',
            paksha: '',
            sunrise: '',
            samvatsara: '',
            shradhatithi: '',
            tithi: '',
            vasara: '',
            year: '',
            vishesha: '',
            yoga: '',
            sunset: '');
        day.date = element['date'].toString();
        day.month = element['month'].toString();
        day.year = element['year'].toString();
        day.samvatsara = element['samvatsara'].toString();
        day.ayana = element["ayana"].toString();
        day.paksha = element["paksha"].toString();
        day.rutu = element['rutu'].toString();
        day.masa = element['masa'].toString();
        day.masaniyamaka = element['masaniyamaka'].toString();
        day.calendarmark = element['calendarmark'].toString();
        day.vasara = element["vasara"].toString();
        day.nakshatra = element['nakshatra'].toString();
        day.tithi = element['tithi'].toString();
        day.yoga = element['yoga'].toString();
        day.karana = element['karana'].toString();
        day.sunrise = element['sunrise'].toString();
        day.sunset = element["sunset"].toString();
        day.shradhatithi = element['shradhatithi'].toString();
        day.vishesha = element['vishesha'].toString();
        panchangalistmodelUpdate.add(day);
      });
      getUpdateCompare();

      // }

    } else {
      print("Inside Kannada Panchanga Update else");
      var raw = await rootBundle.loadString('$path/updatedDataKannada.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getUpdateCompare() async {
    // print(panchangalistmodel[0].date);
    // print(panchangalistmodelUpdate[0].date);
    var i, j;
    print(panchangalistmodel.toString());
    print(panchangalistmodel.length);
    print(panchangalistmodelUpdate.length);

    for (i = 0; i < panchangalistmodel.length; i++) {
      for (j = 0; j < panchangalistmodelUpdate.length; j++) {
        if (panchangalistmodel[i].date == panchangalistmodelUpdate[j].date &&
            panchangalistmodel[i].month == panchangalistmodelUpdate[j].month &&
            panchangalistmodel[i].year == panchangalistmodelUpdate[j].year) {
          print(panchangalistmodel[i].date +
              panchangalistmodel[i].month +
              panchangalistmodel[i].year +
              panchangalistmodel[i].samvatsara +
              panchangalistmodel[i].ayana +
              panchangalistmodel[i].paksha +
              panchangalistmodel[i].yoga +
              panchangalistmodel[i].rutu +
              panchangalistmodel[i].masaniyamaka +
              panchangalistmodel[i].tithi +
              panchangalistmodel[i].nakshatra +
              panchangalistmodel[i].karana +
              panchangalistmodel[i].vishesha);

          panchangalistmodel[i].date = panchangalistmodelUpdate[j].date;
          panchangalistmodel[i].month = panchangalistmodelUpdate[j].month;
          panchangalistmodel[i].year = panchangalistmodelUpdate[j].year;
          panchangalistmodel[i].samvatsara =
              panchangalistmodelUpdate[j].samvatsara;
          panchangalistmodel[i].ayana = panchangalistmodelUpdate[j].ayana;
          panchangalistmodel[i].paksha = panchangalistmodelUpdate[j].paksha;
          panchangalistmodel[i].yoga = panchangalistmodelUpdate[j].yoga;
          panchangalistmodel[i].rutu = panchangalistmodelUpdate[j].rutu;
          panchangalistmodel[i].masaniyamaka =
              panchangalistmodelUpdate[j].masaniyamaka;
          panchangalistmodel[i].tithi = panchangalistmodelUpdate[j].tithi;
          panchangalistmodel[i].nakshatra =
              panchangalistmodelUpdate[j].nakshatra;
          panchangalistmodel[i].karana = panchangalistmodelUpdate[j].karana;
          panchangalistmodel[i].vishesha = panchangalistmodelUpdate[j].vishesha;
        }
      }
    }
  }

  getHindiPanchanga() async {
    File? myfile;
    File? myUpdatedfile;
    myfile = await localHindiFile;
    // await Future.delayed(Duration(seconds: 2));
    myUpdatedfile = await localUpdateHindiFile;
    String? contents = await myfile.readAsString();
    print(contents);
    print("Inside Hindi Panchanga");
    if (contents.isEmpty == true) {
      print("Inside Hindi Panchanga If");
      var raw = await http.get(Uri.parse(appScriptURLHindi));
      // var raw = await http.get(Uri.parse(appScriptURLEnglish));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });

      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      print("Inside Hindi Panchanga else");
      var raw = await rootBundle.loadString('$path/HindiLanguage.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
    if (updatelanguage == true) {
      print("Inside Hindi Panchanga Update If");
      var request = appScriptURLHindi + "?aaa=hit";
      // var request = Uri.parse(appScriptURLEnglish).queryParameters["aaa"];
      print(request);
      // if (request != null) {
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      print(myUpdatedfile.writeAsString(jsondata));
      myUpdatedfile.writeAsString(jsondata);
      // getUpdateDayObject();
      String? compare2 = await myUpdatedfile.readAsString();
      var comparejson2 = convert.jsonDecode(compare2);
      comparejson2.forEach((element) {
        // print('Default English Panchanga List');
        // print(element);
        Day day = new Day(
            ayana: '',
            karana: '',
            date: '',
            calendarmark: '',
            masa: '',
            masaniyamaka: '',
            month: '',
            rutu: '',
            nakshatra: '',
            paksha: '',
            sunrise: '',
            samvatsara: '',
            shradhatithi: '',
            tithi: '',
            vasara: '',
            year: '',
            vishesha: '',
            yoga: '',
            sunset: '');
        day.date = element['date'].toString();
        day.month = element['month'].toString();
        day.year = element['year'].toString();
        day.samvatsara = element['samvatsara'].toString();
        day.ayana = element["ayana"].toString();
        day.paksha = element["paksha"].toString();
        day.rutu = element['rutu'].toString();
        day.masa = element['masa'].toString();
        day.masaniyamaka = element['masaniyamaka'].toString();
        day.calendarmark = element['calendarmark'].toString();
        day.vasara = element["vasara"].toString();
        day.nakshatra = element['nakshatra'].toString();
        day.tithi = element['tithi'].toString();
        day.yoga = element['yoga'].toString();
        day.karana = element['karana'].toString();
        day.sunrise = element['sunrise'].toString();
        day.sunset = element["sunset"].toString();
        day.shradhatithi = element['shradhatithi'].toString();
        day.vishesha = element['vishesha'].toString();
        panchangalistmodelUpdate.add(day);
      });
      getUpdateCompare();

      // }

    } else {
      print("Inside Hindi Panchanga Update else");
      var raw = await rootBundle.loadString('$path/updatedDataHindi.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getTamilPanchanga() async {
    File? myfile;
    File? myUpdatedfile;
    myfile = await localTamilFile;
    // await Future.delayed(Duration(seconds: 2));
    myUpdatedfile = await localUpdateTamilFile;
    String? contents = await myfile.readAsString();
    print(contents);
    print("Inside Tamil Panchanga");
    if (contents.isEmpty == true) {
      print("Inside Tamil Panchanga If");
      var raw = await http.get(Uri.parse(appScriptURLTamil));
      // var raw = await http.get(Uri.parse(appScriptURLEnglish));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });

      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      print("Inside Tamil Panchanga else");
      var raw = await rootBundle.loadString('$path/TamilLanguage.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
    if (updatelanguage == true) {
      print("Inside Tamil Panchanga Update If");
      var request = appScriptURLTamil + "?aaa=hit";
      // var request = Uri.parse(appScriptURLEnglish).queryParameters["aaa"];
      print(request);
      // if (request != null) {
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      print(myUpdatedfile.writeAsString(jsondata));
      myUpdatedfile.writeAsString(jsondata);
      // getUpdateDayObject();
      String? compare2 = await myUpdatedfile.readAsString();
      var comparejson2 = convert.jsonDecode(compare2);
      comparejson2.forEach((element) {
        // print('Default English Panchanga List');
        // print(element);
        Day day = new Day(
            ayana: '',
            karana: '',
            date: '',
            calendarmark: '',
            masa: '',
            masaniyamaka: '',
            month: '',
            rutu: '',
            nakshatra: '',
            paksha: '',
            sunrise: '',
            samvatsara: '',
            shradhatithi: '',
            tithi: '',
            vasara: '',
            year: '',
            vishesha: '',
            yoga: '',
            sunset: '');
        day.date = element['date'].toString();
        day.month = element['month'].toString();
        day.year = element['year'].toString();
        day.samvatsara = element['samvatsara'].toString();
        day.ayana = element["ayana"].toString();
        day.paksha = element["paksha"].toString();
        day.rutu = element['rutu'].toString();
        day.masa = element['masa'].toString();
        day.masaniyamaka = element['masaniyamaka'].toString();
        day.calendarmark = element['calendarmark'].toString();
        day.vasara = element["vasara"].toString();
        day.nakshatra = element['nakshatra'].toString();
        day.tithi = element['tithi'].toString();
        day.yoga = element['yoga'].toString();
        day.karana = element['karana'].toString();
        day.sunrise = element['sunrise'].toString();
        day.sunset = element["sunset"].toString();
        day.shradhatithi = element['shradhatithi'].toString();
        day.vishesha = element['vishesha'].toString();
        panchangalistmodelUpdate.add(day);
      });
      getUpdateCompare();

      // }

    } else {
      print("Inside Tamil Panchanga Update else");
      var raw = await rootBundle.loadString('$path/updatedDataTamil.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getTeluguPanchanga() async {
    File? myfile;
    File? myUpdatedfile;
    myfile = await localTeluguFile;
    // await Future.delayed(Duration(seconds: 2));
    myUpdatedfile = await localUpdateTeluguFile;
    String? contents = await myfile.readAsString();
    print(contents);
    print("Inside Telugu Panchanga");
    if (contents.isEmpty == true) {
      print("Inside Telugu Panchanga If");
      var raw = await http.get(Uri.parse(appScriptURLTelugu));
      // var raw = await http.get(Uri.parse(appScriptURLEnglish));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });

      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      print("Inside Telugu Panchanga else");
      var raw = await rootBundle.loadString('$path/TeluguLanguage.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
    if (updatelanguage == true) {
      print("Inside Telugu Panchanga Update If");
      var request = appScriptURLTelugu + "?aaa=hit";
      // var request = Uri.parse(appScriptURLEnglish).queryParameters["aaa"];
      print(request);
      // if (request != null) {
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      print(myUpdatedfile.writeAsString(jsondata));
      myUpdatedfile.writeAsString(jsondata);
      // getUpdateDayObject();
      String? compare2 = await myUpdatedfile.readAsString();
      var comparejson2 = convert.jsonDecode(compare2);
      comparejson2.forEach((element) {
        // print('Default English Panchanga List');
        // print(element);
        Day day = new Day(
            ayana: '',
            karana: '',
            date: '',
            calendarmark: '',
            masa: '',
            masaniyamaka: '',
            month: '',
            rutu: '',
            nakshatra: '',
            paksha: '',
            sunrise: '',
            samvatsara: '',
            shradhatithi: '',
            tithi: '',
            vasara: '',
            year: '',
            vishesha: '',
            yoga: '',
            sunset: '');
        day.date = element['date'].toString();
        day.month = element['month'].toString();
        day.year = element['year'].toString();
        day.samvatsara = element['samvatsara'].toString();
        day.ayana = element["ayana"].toString();
        day.paksha = element["paksha"].toString();
        day.rutu = element['rutu'].toString();
        day.masa = element['masa'].toString();
        day.masaniyamaka = element['masaniyamaka'].toString();
        day.calendarmark = element['calendarmark'].toString();
        day.vasara = element["vasara"].toString();
        day.nakshatra = element['nakshatra'].toString();
        day.tithi = element['tithi'].toString();
        day.yoga = element['yoga'].toString();
        day.karana = element['karana'].toString();
        day.sunrise = element['sunrise'].toString();
        day.sunset = element["sunset"].toString();
        day.shradhatithi = element['shradhatithi'].toString();
        day.vishesha = element['vishesha'].toString();
        panchangalistmodelUpdate.add(day);
      });
      getUpdateCompare();

      // }

    } else {
      print("Inside Telugu Panchanga Update else");
      var raw = await rootBundle.loadString('$path/updatedDataTelugu.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getSanskritPanchanga() async {
    File? myfile;
    File? myUpdatedfile;
    myfile = await localSanskritFile;
    // await Future.delayed(Duration(seconds: 2));
    myUpdatedfile = await localUpdateSanskritFile;
    String? contents = await myfile.readAsString();
    print(contents);
    print("Inside Sanskrit Panchanga");
    if (contents.isEmpty == true) {
      print("Inside Sanskrit Panchanga If");
      var raw = await http.get(Uri.parse(appScriptURLSanskrit));
      // var raw = await http.get(Uri.parse(appScriptURLEnglish));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });

      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      print("Inside English Panchanga else");
      var raw = await rootBundle.loadString('$path/SanskritLanguage.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
    if (updatelanguage == true) {
      print("Inside English Panchanga Update If");
      var request = appScriptURLSanskrit + "?aaa=hit";
      // var request = Uri.parse(appScriptURLEnglish).queryParameters["aaa"];
      print(request);
      // if (request != null) {
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      // final file = await _localFile;
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      print(myUpdatedfile.writeAsString(jsondata));
      myUpdatedfile.writeAsString(jsondata);
      // getUpdateDayObject();
      String? compare2 = await myUpdatedfile.readAsString();
      var comparejson2 = convert.jsonDecode(compare2);
      comparejson2.forEach((element) {
        // print('Default English Panchanga List');
        // print(element);
        Day day = new Day(
            ayana: '',
            karana: '',
            date: '',
            calendarmark: '',
            masa: '',
            masaniyamaka: '',
            month: '',
            rutu: '',
            nakshatra: '',
            paksha: '',
            sunrise: '',
            samvatsara: '',
            shradhatithi: '',
            tithi: '',
            vasara: '',
            year: '',
            vishesha: '',
            yoga: '',
            sunset: '');
        day.date = element['date'].toString();
        day.month = element['month'].toString();
        day.year = element['year'].toString();
        day.samvatsara = element['samvatsara'].toString();
        day.ayana = element["ayana"].toString();
        day.paksha = element["paksha"].toString();
        day.rutu = element['rutu'].toString();
        day.masa = element['masa'].toString();
        day.masaniyamaka = element['masaniyamaka'].toString();
        day.calendarmark = element['calendarmark'].toString();
        day.vasara = element["vasara"].toString();
        day.nakshatra = element['nakshatra'].toString();
        day.tithi = element['tithi'].toString();
        day.yoga = element['yoga'].toString();
        day.karana = element['karana'].toString();
        day.sunrise = element['sunrise'].toString();
        day.sunset = element["sunset"].toString();
        day.shradhatithi = element['shradhatithi'].toString();
        day.vishesha = element['vishesha'].toString();
        panchangalistmodelUpdate.add(day);
      });
      getUpdateCompare();

      // }

    } else {
      print("Inside Sanksrit Panchanga Update else");
      var raw = await rootBundle.loadString('$path/updatedDataSanskrit.json');
      jsonPanchanga = convert.jsonDecode(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getPanchangaDataFromSheet() async {
    // var raw = await http.get(Uri.parse(appScriptURLEnglish));
    // jsonPanchanga = convert.jsonDecode(raw.body);
    jsonPanchanga.forEach((element) {
      // print('Default English Panchanga List');
      // print(element);
      Day day = new Day(
          ayana: '',
          karana: '',
          date: '',
          calendarmark: '',
          masa: '',
          masaniyamaka: '',
          month: '',
          rutu: '',
          nakshatra: '',
          paksha: '',
          sunrise: '',
          samvatsara: '',
          shradhatithi: '',
          tithi: '',
          vasara: '',
          year: '',
          vishesha: '',
          yoga: '',
          sunset: '');
      day.date = element['date'].toString();
      day.month = element['month'].toString();
      day.year = element['year'].toString();
      day.samvatsara = element['samvatsara'].toString();
      day.ayana = element["ayana"].toString();
      day.paksha = element["paksha"].toString();
      day.rutu = element['rutu'].toString();
      day.masa = element['masa'].toString();
      day.masaniyamaka = element['masaniyamaka'].toString();
      day.calendarmark = element['calendarmark'].toString();
      day.vasara = element["vasara"].toString();
      day.nakshatra = element['nakshatra'].toString();
      day.tithi = element['tithi'].toString();
      day.yoga = element['yoga'].toString();
      day.karana = element['karana'].toString();
      day.sunrise = element['sunrise'].toString();
      day.sunset = element["sunset"].toString();
      day.shradhatithi = element['shradhatithi'].toString();
      day.vishesha = element['vishesha'].toString();
      panchangalistmodel.add(day);
    });
  }

  @override
  void initState() {
    // getPanchangaDataFromSheet();
    print("Inside the init");

    switch (langValue) {
      case 1:
        getEnglishPanchanga();
        super.initState();
        break;
      case 2:
        getKannadaPanchanga();
        super.initState();
        break;
      case 3:
        getHindiPanchanga();
        super.initState();
        break;
      case 4:
        getTamilPanchanga();
        super.initState();
        break;
      case 5:
        getTeluguPanchanga();
        super.initState();
        break;
      case 6:
        getSanskritPanchanga();
        super.initState();
        break;
      default:
        getEnglishPanchanga();
        super.initState();
        break;
    }
  }

  // Stream<Widget> aaa = (() async* {
  //   await Future<Void>.delayed(const Duration(seconds: 5));
  //   yield DisplayDesign(
  //       ayana: '',
  //       karana: '',
  //       date: '',
  //       calendarmark: '',
  //       masa: '',
  //       masaniyamaka: '',
  //       month: '',
  //       rutu: '',
  //       nakshatra: '',
  //       paksha: '',
  //       sunrise: '',
  //       samvatsara: '',
  //       shradhatithi: '',
  //       tithi: '',
  //       vasara: '',
  //       year: '',
  //       vishesha: '',
  //       yoga: '',
  //       sunset: '');
  // })();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Panchanga",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 247, 206, 73),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search, color: Colors.black),
          ),
          _NomalPopMenu(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 206, 73),
              ),
              child: Text('Drawer'),
            ),
            ListTile(
              title: const Text('Aradhane'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Ekadashi'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Festivals / Special days'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Tarapana'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Shubha / Ashuba'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body:
          //  StreamBuilder(
          //     stream: aaa,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator.adaptive());
          //       }
          //       if (!snapshot.hasData) {
          //         return const Text('snfuajskdfijhaskdfijadsfaijodfjaodis');
          //       } else {
          //         return
          Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
            itemCount: panchangalistmodel.length,
            // scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return DisplayDesign(
                date: panchangalistmodel[index].date,
                month: panchangalistmodel[index].month,
                year: panchangalistmodel[index].year,
                samvatsara: panchangalistmodel[index].samvatsara,
                ayana: panchangalistmodel[index].ayana,
                rutu: panchangalistmodel[index].rutu,
                masa: panchangalistmodel[index].masa,
                masaniyamaka: panchangalistmodel[index].masaniyamaka,
                calendarmark: panchangalistmodel[index].calendarmark,
                vasara: panchangalistmodel[index].vasara,
                nakshatra: panchangalistmodel[index].nakshatra,
                yoga: panchangalistmodel[index].yoga,
                karana: panchangalistmodel[index].karana,
                sunrise: panchangalistmodel[index].sunrise,
                sunset: panchangalistmodel[index].sunset,
                tithi: panchangalistmodel[index].tithi,
                paksha: panchangalistmodel[index].paksha,
                shradhatithi: panchangalistmodel[index].shradhatithi,
                vishesha: panchangalistmodel[index].vishesha,
              );
            }),
      ),
      // }
      // }),
    );
  }

// ignore: non_constant_identifier_names
  Widget _NomalPopMenu() {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert, color: Colors.black),
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: TextButton(
            child: const Text('Language'),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 450,
                    color: Color.fromARGB(255, 232, 220, 184),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Select Language'),
                          RadioListTile(
                            title: Text("English"),
                            value: "1",
                            groupValue: langValue,
                            onChanged: (value) {
                              setState(() {
                                // gender = value.toString();
                                langValue = value;
                                panchangalistmodel.clear();
                                getEnglishPanchanga();
                                // super.initState();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Kannada"),
                            value: "2",
                            groupValue: langValue,
                            onChanged: (value) {
                              setState(() {
                                langValue = value;
                                // getKannadaPanchanga();
                                // trans();
                                panchangalistmodel.clear();
                                getKannadaPanchanga();
                                // super.initState();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Hindi"),
                            value: "3",
                            groupValue: langValue,
                            onChanged: (value) {
                              setState(() {
                                langValue = value;
                                panchangalistmodel.clear();
                                getHindiPanchanga();
                                // super.initState();
                                // trans();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Tamil"),
                            value: "4",
                            groupValue: langValue,
                            onChanged: (value) {
                              setState(() {
                                langValue = value;
                                panchangalistmodel.clear();
                                getTamilPanchanga();
                                // super.initState();
                                // trans();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Telugu"),
                            value: "5",
                            groupValue: langValue,
                            onChanged: (value) {
                              setState(() {
                                langValue = value;
                                panchangalistmodel.clear();
                                getTeluguPanchanga();
                                // super.initState();
                                // trans();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Sanskrit"),
                            value: "6",
                            groupValue: langValue,
                            onChanged: (value) {
                              setState(() {
                                langValue = value;
                                panchangalistmodel.clear();
                                getSanskritPanchanga();
                                // super.initState();
                                // trans();
                              });
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Close'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        PopupMenuItem<int>(
            value: 2,
            child: TextButton(
              child: const Text('Update'),
              onPressed: () {
                // output = 'updateApp';
                updatelanguage = true;
                panchangalistmodel.clear();
                // getUpdatedEnglishPanchanga();
                getEnglishPanchanga();
                getKannadaPanchanga();
                getHindiPanchanga();
                getSanskritPanchanga();
                getTamilPanchanga();
                getTeluguPanchanga();
              },
            )),
        PopupMenuItem<int>(
            value: 2,
            child: TextButton(
              child: const Text('Exit'),
              onPressed: () {
                exit(0);
              },
            )),
      ],
    );
  }
}

class PanchangaTitle extends StatefulWidget {
  @override
  State<PanchangaTitle> createState() => _PanchangaTitleState();
}

class _PanchangaTitleState extends State<PanchangaTitle> {
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(
      initialPage: 0,
    );
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        DisplayDesign(
          ayana: '',
          karana: '',
          date: '',
          calendarmark: '',
          masa: '',
          masaniyamaka: '',
          month: '',
          rutu: '',
          nakshatra: '',
          paksha: '',
          sunrise: '',
          samvatsara: '',
          shradhatithi: '',
          tithi: '',
          vasara: '',
          year: '',
          vishesha: '',
          yoga: '',
          sunset: '',
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DisplayDesign extends StatefulWidget {
  final String date,
      month,
      year,
      samvatsara,
      ayana,
      rutu,
      masa,
      masaniyamaka,
      paksha,
      tithi,
      calendarmark,
      vasara,
      nakshatra,
      yoga,
      karana,
      sunrise,
      sunset,
      shradhatithi,
      vishesha;
  DisplayDesign(
      {required this.date,
      required this.month,
      required this.year,
      required this.samvatsara,
      required this.ayana,
      required this.rutu,
      required this.masa,
      required this.masaniyamaka,
      required this.paksha,
      required this.tithi,
      required this.calendarmark,
      required this.vasara,
      required this.nakshatra,
      required this.yoga,
      required this.karana,
      required this.sunrise,
      required this.sunset,
      required this.shradhatithi,
      required this.vishesha});

  @override
  State<DisplayDesign> createState() => _DisplayDesignState();
}

class _DisplayDesignState extends State<DisplayDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      child: SizedBox(
        child: Container(
          color: Color.fromARGB(255, 245, 240, 225),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(width: 0),
                    Row(
                      children: [
                        Icon(
                          Icons.sunny,
                          size: 18,
                        ),
                        Text(
                          'Sunrise',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 2),
                        // Text(
                        //   sunrise,
                        //   style: TextStyle(fontSize: 15),
                        // ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.sunny,
                          size: 18,
                        ),
                        Text(
                          'SunSet',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 2),
                        // Text(
                        //   sunset,
                        //   style: TextStyle(fontSize: 15),
                        // ),
                        IconButton(
                          iconSize: 20,
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {},
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '/',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          widget.month,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '/',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          widget.year,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.samvatsara,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ] //Samvasthara goes here
                  ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              SizedBox(height: 10),
              SizedBox(
                // padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    //The first row of Ayana, Masa, Paksha, Vasara and yoga goes here
                    Container(
                      padding: EdgeInsets.all(15),
                      color: Color.fromARGB(255, 245, 240, 225),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ayana :',
                                textAlign: TextAlign.left,
                                style: TextStyle(),
                              ),
                              SizedBox(width: 20),
                              Text(
                                widget.ayana,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Masa :', textAlign: TextAlign.center),
                              SizedBox(width: 20),
                              Text(widget.masa,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Paksha :', textAlign: TextAlign.center),
                              SizedBox(width: 20),
                              Text(widget.paksha,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Vasara :', textAlign: TextAlign.center),
                              SizedBox(width: 20),
                              Text(widget.vasara,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Yoga :', textAlign: TextAlign.center),
                              SizedBox(width: 20),
                              Text(widget.yoga,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Rutu :', textAlign: TextAlign.center),
                              SizedBox(width: 20),
                              Text(widget.rutu,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Masa Niyamaka :',
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: Text(widget.masaniyamaka,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Tithi :', textAlign: TextAlign.center),
                              SizedBox(width: 20),
                              Text(widget.tithi,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Nakshatra :', textAlign: TextAlign.left),
                              SizedBox(width: 20),
                              Text(widget.nakshatra,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Karana :', textAlign: TextAlign.left),
                              SizedBox(width: 20),
                              Text(widget.karana,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Today's Special goes here
              // SizedBox(height: 10),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Special",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              widget.vishesha,

                              // sunriseSunset.sunrise.toString()
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
