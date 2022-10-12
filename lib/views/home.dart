import 'dart:core';
// import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
import 'dart:io';
import 'package:panchanga/views/search_in_list.dart';
import 'package:panchanga/panchanga_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:panchanga/views/calendar_event.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:panchanga/views/calendar_event.dart';

// ignore: must_be_immutable
class Panchanga extends StatefulWidget {
  DateTime differenceDate;
  // Panchanga data;
  Panchanga({Key? key, required this.differenceDate}) : super(key: key);
  @override
  _PanchangaState createState() => _PanchangaState();
}

class _PanchangaState extends State<Panchanga> {
  dynamic dateDataIndex;
  dynamic dateIndex;
  var langValue;

  var langSettingsValue;

  var settingsLanguage;
  var updatelanguage;
  var difference;
  late Day updatedDay;
  var jsonPanchanga;
  var jsonPanchangaUpdate;

  DateTime specificDate = DateTime.now();
  // final newYear = DateTime(2022, 04, 01);
  // final currentDate = DateTime.now();
  List<Day> panchangalistmodel = <Day>[];
  List<Day> panchangalistmodelUpdate = <Day>[];
  List<Day> updatedEnglishPanchanaga = <Day>[];
  List<Day> updatedKannadaPanchanaga = <Day>[];
  List<Day> updatedHindiPanchanaga = <Day>[];
  List<Day> updatedTamilPanchanaga = <Day>[];
  List<Day> updatedTeluguPanchanaga = <Day>[];
  List<Day> updatedSanskritPanchanaga = <Day>[];

  // pageController = pageController ??
  //         PageController(
  //             viewportFraction: viewportFraction,
  //             initialPage: items.length < 2 ? 0 : virtualCount,
  //             keepPage: false),
  //     super(key: key);
// ili paaa

  var path;
  File? mySettingsFile;
  Future<Object> get localSettingsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localSettingsFile async {
    path = await localSettingsPath;
    // print("Settings");
    print(path);
    return new File('$path/settings.txt').create(recursive: true);
  }

  Future<Object> get localPathEnglish async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localEnglishFile async {
    path = await localPathEnglish;
    // print("English");
    // print(path);
    return new File('$path/EnglishLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateEnglishFile async {
    path = await localPathEnglish;
    // print("Updated English");
    // print(path);
    return new File('$path/updatedDataEnglish.json').create(recursive: true);
  }

  Future<String> get localPathKannada async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localKannadaFile async {
    path = await localPathKannada;
    // print("Kannada");
    // print(path);
    return new File('$path/KannadaLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateKannadaFile async {
    path = await localPathKannada;
    // print("Updated kannada");
    // print(path);
    return new File('$path/updatedDataKannada.json').create(recursive: true);
  }

  Future<String> get localPathHindi async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localHindiFile async {
    path = await localPathHindi;
    // print(" Hindi");
    // print(path);
    return new File('$path/HindiLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateHindiFile async {
    path = await localPathHindi;
    // print(path);
    return new File('$path/updatedDataHindi.json').create(recursive: true);
  }

  Future<String> get localPathTamil async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localTamilFile async {
    path = await localPathTamil;
    // print("Tamil");
    // print(path);
    return new File('$path/TamilLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateTamilFile async {
    path = await localPathTamil;
    // print("Updated Tamil");
    // print(path);
    return new File('$path/updatedDataTamil.json').create(recursive: true);
  }

  Future<String> get localPathTelugu async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localTeluguFile async {
    path = await localPathTelugu;
    // print("Telugu");
    // print(path);
    return new File('$path/TeluguLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateTeluguFile async {
    path = await localPathTelugu;
    // print("Updated Telugu");
    // print(path);
    return new File('$path/updatedDataTelugu.json').create(recursive: true);
  }

  Future<String> get localPathSanskrit async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localSanskritFile async {
    path = await localPathSanskrit;
    // print(" Sanskrit");
    // print(path);
    return new File('$path/SanskritLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateSanskritFile async {
    path = await localPathSanskrit;
    // print("Updated Sanskrit");
    // print(path);
    return new File('$path/updatedDataSanskrit.json').create(recursive: true);
  }

  var appScriptURLEnglish =
      'https://script.google.com/macros/s/AKfycbyXsDv68rkWVVnVBlz9JwrYXJbHOImUibFJ1OL0XpS4XczPIqDS2C2HCLgXA1CzRJ1F/exec';
  var appScriptURLKannada =
      "https://script.google.com/macros/s/AKfycbxVZqerGm6bzpJs8p_97aPIdNOEgjCvyqf4FP9o0pO4OAZ0EnVrcFACPDbVQTPfsosP/exec";
  var appScriptURLTelugu =
      "https://script.google.com/macros/s/AKfycbxqhFNyXrPe7y6uqOD_miG4TgASoVvnr0SFJZdz748xRH-5hDlBkhkThttnUpQMEnMf/exec";
  var appScriptURLTamil =
      "https://script.google.com/macros/s/AKfycbyY_-xuTNcKsEE669TVFePlSW-tqFxrWPBtgx-XmM84outXcedKIiTsELr6YO8V2JrzyA/exec";
  var appScriptURLSanskrit =
      "https://script.google.com/macros/s/AKfycbyrnvgdG5Sw52dc7InQolaFoqVre0ZWsm8_AvsxbukfRva1YrdxjviU-72thmfyLsAg9g/exec";
  var appScriptURLHindi =
      "https://script.google.com/macros/s/AKfycbxZtGrRR38cg2ocqy2i1iLdgsYMsXbj9XyXg_PNLxy_zoh4E4hlaWZMuHxY7Vj8DG96/exec";
  getEnglishPanchanga() async {
    langSettingsValue = 1;
    File? myfile;
    File? myUpdatedfile;
    myfile = await localEnglishFile;
    myUpdatedfile = await localUpdateEnglishFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      print(
          "Original English File and Modified English files both are present");
      if (updatedContents.isEmpty == true) {
        jsonPanchangaUpdate = {};
      } else {
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        setState(() {
          // panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedEnglishLanguageData();
          panchangalistmodel.clear();
          getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      print(
          "Original English File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLEnglish));
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
    }
    if (updatelanguage == true) {
      print("Update Pressed getting Modified English files from Remote");
      var request = appScriptURLEnglish + "?aaa=hit";
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      // print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      myUpdatedfile.writeAsString(jsondata);
      String? updatedContents = await myUpdatedfile.readAsString();
      jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
      jsonPanchangaUpdate.forEach((element) {
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
      setState(() {
        // panchangalistmodel.clear();
        panchangalistmodelUpdate.clear();
        getUpdatedEnglishLanguageData();
        panchangalistmodel.clear();
        getUpdateLanguageCompareData();
      });
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      print("Just show Original English File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      setState(() {
        panchangalistmodel.clear();
        getPanchangaDataFromSheet();
      });
    }
  }

  getKannadaPanchanga() async {
    langSettingsValue = 2;
    File? myfile;
    File? myUpdatedfile;
    myfile = await localKannadaFile;
    myUpdatedfile = await localUpdateKannadaFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      print(
          "Original Kannada File and Modified Kannada files both are present");
      if (updatedContents.isEmpty == true) {
        jsonPanchangaUpdate = {};
      } else {
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        setState(() {
          // panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedKannadaLanguageData();
          panchangalistmodel.clear();

          getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      print(
          "Original Kannada File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLKannada));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    }
    if (updatelanguage == true) {
      print("Update Pressed getting Modified Kannada file from Remote");
      var request = appScriptURLKannada + "?aaa=hit";
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      // print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      myUpdatedfile.writeAsString(jsondata);
      String? updatedContents = await myUpdatedfile.readAsString();
      jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
      jsonPanchangaUpdate.forEach((element) {
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
      setState(() {
        // panchangalistmodel.clear();
        panchangalistmodelUpdate.clear();

        getUpdatedKannadaLanguageData();
        panchangalistmodel.clear();

        getUpdateLanguageCompareData();
      });
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      print("Just show Original Kannada File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getHindiPanchanga() async {
    langSettingsValue = 3;
    File? myfile;
    File? myUpdatedfile;
    myfile = await localHindiFile;
    myUpdatedfile = await localUpdateHindiFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      print("Original Hindi File and Modified Hindi file both are present");
      if (updatedContents.isEmpty == true) {
        jsonPanchangaUpdate = {};
      } else {
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        setState(() {
          // panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedHindiLanguageData();
          panchangalistmodel.clear();

          getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      print(
          "Original Hindi File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLHindi));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    }
    if (updatelanguage == true) {
      print("Update Pressed getting Modified Hindi files from Remote");
      var request = appScriptURLHindi + "?aaa=hit";
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      myUpdatedfile.writeAsString(jsondata);
      String? updatedContents = await myUpdatedfile.readAsString();
      jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
      jsonPanchangaUpdate.forEach((element) {
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
      setState(() {
        panchangalistmodelUpdate.clear();
        getUpdatedHindiLanguageData();
        panchangalistmodel.clear();
        getUpdateLanguageCompareData();
      });
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      print("Just show Original Hindi File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getTamilPanchanga() async {
    langSettingsValue = 4;
    File? myfile;
    File? myUpdatedfile;
    myfile = await localTamilFile;
    myUpdatedfile = await localUpdateTamilFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      print("Original Tamil File and Modified Tamil files both are present");
      if (updatedContents.isEmpty == true) {
        jsonPanchangaUpdate = {};
      } else {
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedTamilLanguageData();
          getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      print(
          "Original Tamil  File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLTamil));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    }
    if (updatelanguage == true) {
      print("Update Pressed getting Tamil Modified file from Remote");
      var request = appScriptURLTamil + "?aaa=hit";
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      myUpdatedfile.writeAsString(jsondata);
      String? updatedContents = await myUpdatedfile.readAsString();
      jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
      jsonPanchangaUpdate.forEach((element) {
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
      setState(() {
        // panchangalistmodel.clear();
        panchangalistmodelUpdate.clear();

        getUpdatedTamilLanguageData();
        panchangalistmodel.clear();

        getUpdateLanguageCompareData();
      });
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      print("Just show Original Tamil File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getTeluguPanchanga() async {
    langSettingsValue = 5;
    File? myfile;
    File? myUpdatedfile;
    myfile = await localTeluguFile;
    myUpdatedfile = await localUpdateTeluguFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      print("Original Telugu File and Modified Telugu files both are present");
      if (updatedContents.isEmpty == true) {
        jsonPanchangaUpdate = {};
      } else {
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedTeluguLanguageData();
          getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      print(
          "Original Telugu File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLTelugu));
      jsonPanchanga = convert.jsonDecode(raw.body);

      setState(() {
        getPanchangaDataFromSheet();
      });

      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    }
    if (updatelanguage == true) {
      print("Update Pressed getting Telugu Modified files from Remote");
      var request = appScriptURLTelugu + "?aaa=hit";
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      // print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      myUpdatedfile.writeAsString(jsondata);
      String? updatedContents = await myUpdatedfile.readAsString();
      jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
      jsonPanchangaUpdate.forEach((element) {
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
      setState(() {
        // panchangalistmodel.clear();
        panchangalistmodelUpdate.clear();

        getUpdatedTeluguLanguageData();
        panchangalistmodel.clear();

        getUpdateLanguageCompareData();
      });
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      print("Just show Original Telugu File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getSanskritPanchanga() async {
    langSettingsValue = 6;
    File? myfile;
    File? myUpdatedfile;
    myfile = await localSanskritFile;
    myUpdatedfile = await localUpdateSanskritFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      print(
          "Original Sanskrit File and Modified Telugu both files are present");
      if (updatedContents.isEmpty == true) {
        jsonPanchangaUpdate = {};
      } else {
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        setState(() {
          // panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedSanskritLanguageData();
          panchangalistmodel.clear();

          getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      print(
          "Original Sanskrit File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLSanskrit));
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
    }
    if (updatelanguage == true) {
      print("Update Pressed getting Modified Telugu files from Remote");
      var request = appScriptURLSanskrit + "?aaa=hit";
      await http.post(Uri.parse(request));
      var raw = await http.get(Uri.parse(request));
      // print(raw);
      setState(() {
        getPanchangaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      myUpdatedfile.writeAsString(jsondata);
      String? updatedContents = await myUpdatedfile.readAsString();
      jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
      jsonPanchangaUpdate.forEach((element) {
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
      setState(() {
        // panchangalistmodel.clear();
        panchangalistmodelUpdate.clear();
        getUpdatedSanskritLanguageData();
        panchangalistmodel.clear();

        getUpdateLanguageCompareData();
      });
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      print("Just show Original Sanskrit File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      setState(() {
        getPanchangaDataFromSheet();
      });
    }
  }

  getUpdatedEnglishLanguageData() {
    jsonPanchangaUpdate.forEach((element) {
      updatedDay = new Day(
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
      updatedDay.date = element['date'].toString();
      updatedDay.month = element['month'].toString();
      updatedDay.year = element['year'].toString();
      updatedDay.samvatsara = element['samvatsara'].toString();
      updatedDay.ayana = element["ayana"].toString();
      updatedDay.paksha = element["paksha"].toString();
      updatedDay.rutu = element['rutu'].toString();
      updatedDay.masa = element['masa'].toString();
      updatedDay.masaniyamaka = element['masaniyamaka'].toString();
      updatedDay.calendarmark = element['calendarmark'].toString();
      updatedDay.vasara = element["vasara"].toString();
      updatedDay.nakshatra = element['nakshatra'].toString();
      updatedDay.tithi = element['tithi'].toString();
      updatedDay.yoga = element['yoga'].toString();
      updatedDay.karana = element['karana'].toString();
      updatedDay.sunrise = element['sunrise'].toString();
      updatedDay.sunset = element["sunset"].toString();
      updatedDay.shradhatithi = element['shradhatithi'].toString();
      updatedDay.vishesha = element['vishesha'].toString();
      updatedEnglishPanchanaga.add(updatedDay);
    });
  }

  getUpdatedKannadaLanguageData() {
    jsonPanchangaUpdate.forEach((element) {
      updatedDay = new Day(
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
      updatedDay.date = element['date'].toString();
      updatedDay.month = element['month'].toString();
      updatedDay.year = element['year'].toString();
      updatedDay.samvatsara = element['samvatsara'].toString();
      updatedDay.ayana = element["ayana"].toString();
      updatedDay.paksha = element["paksha"].toString();
      updatedDay.rutu = element['rutu'].toString();
      updatedDay.masa = element['masa'].toString();
      updatedDay.masaniyamaka = element['masaniyamaka'].toString();
      updatedDay.calendarmark = element['calendarmark'].toString();
      updatedDay.vasara = element["vasara"].toString();
      updatedDay.nakshatra = element['nakshatra'].toString();
      updatedDay.tithi = element['tithi'].toString();
      updatedDay.yoga = element['yoga'].toString();
      updatedDay.karana = element['karana'].toString();
      updatedDay.sunrise = element['sunrise'].toString();
      updatedDay.sunset = element["sunset"].toString();
      updatedDay.shradhatithi = element['shradhatithi'].toString();
      updatedDay.vishesha = element['vishesha'].toString();
      updatedKannadaPanchanaga.add(updatedDay);
    });
  }

  getUpdatedHindiLanguageData() {
    jsonPanchangaUpdate.forEach((element) {
      updatedDay = new Day(
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
      updatedDay.date = element['date'].toString();
      updatedDay.month = element['month'].toString();
      updatedDay.year = element['year'].toString();
      updatedDay.samvatsara = element['samvatsara'].toString();
      updatedDay.ayana = element["ayana"].toString();
      updatedDay.paksha = element["paksha"].toString();
      updatedDay.rutu = element['rutu'].toString();
      updatedDay.masa = element['masa'].toString();
      updatedDay.masaniyamaka = element['masaniyamaka'].toString();
      updatedDay.calendarmark = element['calendarmark'].toString();
      updatedDay.vasara = element["vasara"].toString();
      updatedDay.nakshatra = element['nakshatra'].toString();
      updatedDay.tithi = element['tithi'].toString();
      updatedDay.yoga = element['yoga'].toString();
      updatedDay.karana = element['karana'].toString();
      updatedDay.sunrise = element['sunrise'].toString();
      updatedDay.sunset = element["sunset"].toString();
      updatedDay.shradhatithi = element['shradhatithi'].toString();
      updatedDay.vishesha = element['vishesha'].toString();
      updatedHindiPanchanaga.add(updatedDay);
    });
  }

  getUpdatedTamilLanguageData() {
    jsonPanchangaUpdate.forEach((element) {
      updatedDay = new Day(
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
      updatedDay.date = element['date'].toString();
      updatedDay.month = element['month'].toString();
      updatedDay.year = element['year'].toString();
      updatedDay.samvatsara = element['samvatsara'].toString();
      updatedDay.ayana = element["ayana"].toString();
      updatedDay.paksha = element["paksha"].toString();
      updatedDay.rutu = element['rutu'].toString();
      updatedDay.masa = element['masa'].toString();
      updatedDay.masaniyamaka = element['masaniyamaka'].toString();
      updatedDay.calendarmark = element['calendarmark'].toString();
      updatedDay.vasara = element["vasara"].toString();
      updatedDay.nakshatra = element['nakshatra'].toString();
      updatedDay.tithi = element['tithi'].toString();
      updatedDay.yoga = element['yoga'].toString();
      updatedDay.karana = element['karana'].toString();
      updatedDay.sunrise = element['sunrise'].toString();
      updatedDay.sunset = element["sunset"].toString();
      updatedDay.shradhatithi = element['shradhatithi'].toString();
      updatedDay.vishesha = element['vishesha'].toString();
      updatedTamilPanchanaga.add(updatedDay);
    });
  }

  getUpdatedTeluguLanguageData() {
    jsonPanchangaUpdate.forEach((element) {
      updatedDay = new Day(
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
      updatedDay.date = element['date'].toString();
      updatedDay.month = element['month'].toString();
      updatedDay.year = element['year'].toString();
      updatedDay.samvatsara = element['samvatsara'].toString();
      updatedDay.ayana = element["ayana"].toString();
      updatedDay.paksha = element["paksha"].toString();
      updatedDay.rutu = element['rutu'].toString();
      updatedDay.masa = element['masa'].toString();
      updatedDay.masaniyamaka = element['masaniyamaka'].toString();
      updatedDay.calendarmark = element['calendarmark'].toString();
      updatedDay.vasara = element["vasara"].toString();
      updatedDay.nakshatra = element['nakshatra'].toString();
      updatedDay.tithi = element['tithi'].toString();
      updatedDay.yoga = element['yoga'].toString();
      updatedDay.karana = element['karana'].toString();
      updatedDay.sunrise = element['sunrise'].toString();
      updatedDay.sunset = element["sunset"].toString();
      updatedDay.shradhatithi = element['shradhatithi'].toString();
      updatedDay.vishesha = element['vishesha'].toString();
      updatedTeluguPanchanaga.add(updatedDay);
    });
  }

  getUpdatedSanskritLanguageData() {
    jsonPanchangaUpdate.forEach((element) {
      updatedDay = new Day(
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
      updatedDay.date = element['date'].toString();
      updatedDay.month = element['month'].toString();
      updatedDay.year = element['year'].toString();
      updatedDay.samvatsara = element['samvatsara'].toString();
      updatedDay.ayana = element["ayana"].toString();
      updatedDay.paksha = element["paksha"].toString();
      updatedDay.rutu = element['rutu'].toString();
      updatedDay.masa = element['masa'].toString();
      updatedDay.masaniyamaka = element['masaniyamaka'].toString();
      updatedDay.calendarmark = element['calendarmark'].toString();
      updatedDay.vasara = element["vasara"].toString();
      updatedDay.nakshatra = element['nakshatra'].toString();
      updatedDay.tithi = element['tithi'].toString();
      updatedDay.yoga = element['yoga'].toString();
      updatedDay.karana = element['karana'].toString();
      updatedDay.sunrise = element['sunrise'].toString();
      updatedDay.sunset = element["sunset"].toString();
      updatedDay.shradhatithi = element['shradhatithi'].toString();
      updatedDay.vishesha = element['vishesha'].toString();
      updatedSanskritPanchanaga.add(updatedDay);
    });
  }

  getUpdateLanguageCompareData() {
    jsonPanchanga.forEach((element) {
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
      if (day.date == updatedDay.date &&
          day.month == updatedDay.month &&
          day.year == updatedDay.year) {
        print("Compare two list data");
        panchangalistmodel.add(updatedDay);
        print(updatedDay.samvatsara);
      } else {
        panchangalistmodel.add(day);
      }
    });
    for (dateDataIndex = 0;
        dateDataIndex < panchangalistmodel.length;
        dateDataIndex++) {
      if (widget.differenceDate.day.toString() ==
              panchangalistmodel[dateDataIndex].date &&
          widget.differenceDate.month.toString() ==
              panchangalistmodel[dateDataIndex].month &&
          widget.differenceDate.year.toString() ==
              panchangalistmodel[dateDataIndex].year) {
        print('Index of the this date is $dateDataIndex');
        dateIndex = dateDataIndex;
      }
    }
    print('Testing Update Data sheets ,$dateDataIndex');
  }

  getPanchangaDataFromSheet() {
    jsonPanchanga.forEach((element) {
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
    // print(panchangalistmodel);
    for (dateDataIndex = 0;
        dateDataIndex < panchangalistmodel.length;
        dateDataIndex++) {
      if (widget.differenceDate.day.toString() ==
              panchangalistmodel[dateDataIndex].date &&
          widget.differenceDate.month.toString() ==
              panchangalistmodel[dateDataIndex].month &&
          widget.differenceDate.year.toString() ==
              panchangalistmodel[dateDataIndex].year) {
        print('Index of the this date is $dateDataIndex');
        dateIndex = dateDataIndex;
      }
    }
    print('Testing,$dateDataIndex');
  }

  @override
  void initState() {
    initialState();
    super.initState();
  }

  void initialState() async {
    // getPanchangaDataFromSheet();
    // rm -rf ./*.tmp
    mySettingsFile = await localSettingsFile;
    String? contents = (await mySettingsFile?.readAsString());
    if (contents!.isNotEmpty) {
      print("Its here");
      settingsLanguage = int.parse(contents);
    }
    //  pageController=PageController(initialPage:widget.index)

    // print(contents);

    switch (settingsLanguage) {
      case 1:
        getEnglishPanchanga();
        // super.initState();
        break;
      case 2:
        getKannadaPanchanga();
        // super.initState();
        break;
      case 3:
        getHindiPanchanga();
        // super.initState();
        break;
      case 4:
        getTamilPanchanga();
        // super.initState();
        break;
      case 5:
        getTeluguPanchanga();
        // super.initState();
        break;
      case 6:
        getSanskritPanchanga();
        // super.initState();
        break;
      default:
        getEnglishPanchanga();
        getSanskritPanchanga();
        getHindiPanchanga();
        getTamilPanchanga();
        getKannadaPanchanga();
        getTeluguPanchanga();

        // getKannadaPanchanga();
        // getHindiPanchanga();
        // getTamilPanchanga();
        // getTeluguPanchanga();
        // getSanskritPanchanga();
        // super.initState();
        break;
    }
    // SearchInList().;
  }

  // final Future<Widget> _delayInWidgetDisplay = Future<Widget>.delayed(
  //   const Duration(seconds: 2),
  //   () => Panchanga(widget.differenceDate),
  // );

  @override
  Widget build(BuildContext context) {
    print('Data from the CalendarDisplay Class${widget.differenceDate}');
    print('Index in Widget $dateIndex');

    if (dateIndex == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "UM Panchanga",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromARGB(255, 247, 206, 73),
        ),
        body: Center(
            child: CircularProgressIndicator(
          color: Color.fromARGB(255, 247, 206, 73),
        )),
      );
    } else {
      PageController controller = new PageController(
        initialPage: dateIndex,
      );
      // BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "U M Panchanga",
            style: TextStyle(
              color: Color.fromARGB(255, 162, 56, 7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromARGB(255, 247, 206, 73),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: IconButton(
                      iconSize: 28,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // print("OnPressed Butten of Search");
                        // print(panchangalistmodel.toString());
                        showSearch(
                            context: context,
                            delegate: SearchInList(panchangalistmodel)
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SearchInList()),
                            // );

                            );
                      },
                    ))

                //     showSearch(
                //   context: context,
                //   delegate: CustomSearchDelegate(),
                // );
                ),
            nomalPopMenu(),
          ],
        ),
        drawer: Drawer(
          // width: 280,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 206, 73),
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://lh5.googleusercontent.com/p/AF1QipPpOk5SBoE7ney7zLqajq77mjYBqueiEFeM5-7T=w1080-k-no",
                        ),
                        fit: BoxFit.cover)),
                child: Text(
                  "Uttaradi Math",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.justify,
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Aradhane'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Ekadashi'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Festivals / Special days'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Tarapana'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Shubha / Ashuba'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
            ],
          ),
        ),
        body:
            // FutureBuilder<Widget>(
            //     // future: _delayInWidgetDisplay,
            //     builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            //   switch (snapshot.connectionState) {
            //     case ConnectionState.waiting:
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     default:
            //       if (snapshot.hasError)
            //         return Text('Error: ${snapshot.error}');
            //       else
            // return
            Container(
          // Use the properties stored in the State class.
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          // decoration: BoxDecoration(
          //   color: Colors.amber,
          //   borderRadius: _borderRadius,
          // ),
          // Define how long the animation should take.
          // duration: const Duration(seconds: 10),
          // Provide an optional curve to make the animation feel smoother.
          // curve: Curves.fastOutSlowIn,

          child: PageView.builder(
              clipBehavior: Clip.hardEdge,

              // dragStartBehavior: DragStartBehavior.down,
              // physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())

              // controller: controller.animateTo(1, duration: Duration(microseconds: 300), curve: Curves.easeInSine),
              controller: controller,
              // allowImplicitScrolling: true,
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
          // ]
        ),
        // }
        // }),
      );
    }
    // }
    // return Scaffold();
  }

  Widget nomalPopMenu() {
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
                            onChanged: (value) async {
                              mySettingsFile = await localSettingsFile;
                              mySettingsFile?.writeAsString(value.toString());
                              setState(() async {
                                langValue = value;
                                langSettingsValue = value;
                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                getEnglishPanchanga();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Kannada"),
                            value: "2",
                            groupValue: langValue,
                            onChanged: (value) async {
                              mySettingsFile = await localSettingsFile;
                              mySettingsFile?.writeAsString(value.toString());
                              setState(() async {
                                langValue = value;
                                langSettingsValue = value;

                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                getKannadaPanchanga();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Hindi"),
                            value: "3",
                            groupValue: langValue,
                            onChanged: (value) async {
                              mySettingsFile = await localSettingsFile;
                              mySettingsFile?.writeAsString(value.toString());
                              setState(() async {
                                langValue = value;
                                langSettingsValue = value;

                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                getHindiPanchanga();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Tamil"),
                            value: "4",
                            groupValue: langValue,
                            onChanged: (value) async {
                              mySettingsFile = await localSettingsFile;
                              mySettingsFile?.writeAsString(value.toString());
                              setState(() async {
                                langValue = value;
                                langSettingsValue = value;

                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                getTamilPanchanga();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Telugu"),
                            value: "5",
                            groupValue: langValue,
                            onChanged: (value) async {
                              mySettingsFile = await localSettingsFile;
                              mySettingsFile?.writeAsString(value.toString());
                              setState(() async {
                                langValue = value;
                                langSettingsValue = value;

                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                getTeluguPanchanga();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Sanskrit"),
                            value: "6",
                            groupValue: langValue,
                            onChanged: (value) async {
                              mySettingsFile = await localSettingsFile;
                              mySettingsFile?.writeAsString(value.toString());
                              setState(() async {
                                langValue = value;
                                langSettingsValue = value;

                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                getSanskritPanchanga();
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
              onPressed: () async {
                updatelanguage = true;
                File? myUpdatedEnglishFile;
                myUpdatedEnglishFile = await localUpdateEnglishFile;
                String? updatedEnglishContents =
                    await myUpdatedEnglishFile.readAsString();

                File? myUpdatedKannadaFile;
                myUpdatedKannadaFile = await localUpdateKannadaFile;
                String? updatedKannadaContents =
                    await myUpdatedKannadaFile.readAsString();

                File? myUpdatedHindiFile;
                myUpdatedHindiFile = await localUpdateHindiFile;
                String? updatedHindiContents =
                    await myUpdatedHindiFile.readAsString();

                File? myUpdatedTamilFile;
                myUpdatedTamilFile = await localUpdateTamilFile;
                String? updatedTamilContents =
                    await myUpdatedTamilFile.readAsString();

                File? myUpdatedTeluguFile;
                myUpdatedTeluguFile = await localUpdateTeluguFile;
                String? updatedTeluguContents =
                    await myUpdatedTeluguFile.readAsString();

                File? myUpdatedSanskritFile;
                myUpdatedSanskritFile = await localUpdateSanskritFile;
                String? updatedSanskritContents =
                    await myUpdatedSanskritFile.readAsString();

                switch (langSettingsValue) {
                  case 1:
                    if (updatedEnglishContents.isEmpty == false) {
                      print("English updated file  empty");

                      jsonPanchangaUpdate = {};
                    } else {
                      print("English updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getEnglishPanchanga();
                    }
                    break;
                  case 2:
                    if (updatedKannadaContents.isEmpty == false) {
                      print("Kannada updated file  empty");
                      jsonPanchangaUpdate = {};
                    } else {
                      print("Kannada updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getKannadaPanchanga();
                    }
                    break;
                  case 3:
                    if (updatedHindiContents.isEmpty == false) {
                      print("Hindi updated file  empty");
                      jsonPanchangaUpdate = {};
                    } else {
                      print("Hindi updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getHindiPanchanga();
                    }
                    break;
                  case 4:
                    if (updatedTamilContents.isEmpty == false) {
                      print("Tamil updated file  empty");
                      jsonPanchangaUpdate = {};
                    } else {
                      print("Tamil updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getTamilPanchanga();
                    }
                    break;
                  case 5:
                    if (updatedTeluguContents.isEmpty == false) {
                      print("Telugu updated file  empty");
                      jsonPanchangaUpdate = {};
                    } else {
                      print("Telugu updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getTeluguPanchanga();
                    }
                    break;
                  case 6:
                    if (updatedSanskritContents.isEmpty == false) {
                      print("Sanskrit updated file  empty");
                      jsonPanchangaUpdate = {};
                    } else {
                      print("Sanskrit updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getSanskritPanchanga();
                    }
                    break;
                }
              },
            )),
        PopupMenuItem<int>(
            value: 3,
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

class PanchangaDay extends StatefulWidget {
  @override
  State<PanchangaDay> createState() => _PanchangaDayState();
}

class _PanchangaDayState extends State<PanchangaDay> {
  @override
  Widget build(BuildContext context) {
    // final newYear = DateTime(2022, 04, 01);
    // final currentDate = DateTime(2022, 09, 21);
    // var difference = currentDate.difference(newYear).inDays;
    return PageView(
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
  var jsonCalendar;
  List<Day> calendarViewListModel = <Day>[];
  var path;
  Future<Object> get localPathEnglish async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localEnglishFile async {
    path = await localPathEnglish;
    // print("English");
    // print(path);
    return new File('$path/EnglishLanguage.json').create(recursive: true);
  }

  getFile() async {
    File? myfile;
    myfile = await localEnglishFile;
    String? contents = await myfile.readAsString();
    jsonCalendar = convert.jsonDecode(contents);
    jsonCalendar.forEach((element) {
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
      calendarViewListModel.add(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    getFile();
    double screenWidth = MediaQuery.of(context).size.width;

    //For height
//     var padding = MediaQuery.of(context).padding;
// double newheight = height - padding.top - padding.bottom;
    return Container(
      // height: 50,
      child: SizedBox(
        child: Container(
          color: Color.fromARGB(255, 245, 240, 225),
          alignment: Alignment.center,
          child: Column(children: <Widget>[
            Divider(
              color: Color.fromARGB(255, 255, 192, 2),
              thickness: 03.0,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                // Padding(
                //   padding: EdgeInsets.all(8),
                //   child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Row(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    SizedBox(width: 5),
                    Icon(
                      Icons.sunny,
                      size: 18,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Sunrise',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      widget.sunrise,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(width: 5),
                    Container(
                        height: 25,
                        width: 1,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 2, 2, 2),
                        )),
                    SizedBox(width: 5),
                    //   ],
                    // ),

                    // Row(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    Icon(
                      Icons.wb_sunny_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'SunSet',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(width: 3),
                    Text(
                      widget.sunset,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(width: 4),
                    Container(
                        height: 25,
                        width: 1,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 2, 2, 2),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Spacer(),
                    IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (CalendarData(
                                    data: calendarViewListModel))));
                      },
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
                    SizedBox(width: 8),
                  ],
                ),
                // ),
                //   ],
                // ),
                // )
              ],
            ),
            // ),
            // SizedBox(height: 10),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ] //Samvasthara goes here
                ),
            Divider(
              color: Color.fromARGB(255, 255, 192, 2),
              thickness: 03.0,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: screenWidth / 2.1,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Ayana',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          SizedBox(height: 5),

                          Text(
                            widget.ayana,
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              // fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 162, 56, 7),
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Masa',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          SizedBox(height: 5),
                          Text(widget.masa,
                              // textAlign: TextAlign.justify,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Paksha',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          SizedBox(height: 5),
                          Text(widget.paksha,
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Vasara',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          SizedBox(height: 5),

                          Text(widget.vasara,
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // ),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Yoga',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          SizedBox(height: 5),

                          // Expanded(
                          //   child:
                          Text(widget.yoga,
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 300,
                    width: 2,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 192, 2),
                    )),
                Container(
                  width: screenWidth / 2,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Rutu',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // Expanded(
                          //   child:
                          SizedBox(height: 5),

                          Text(widget.rutu,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // ),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Expanded(
                          //   child:
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Masa Niyamaka',
                              // textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // ),
                          // Expanded(
                          //   child:
                          SizedBox(height: 5),

                          Text(widget.masaniyamaka,
                              // textAlign: TextAlign.justify,
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 2,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // ),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Tithi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // Expanded(
                          //   child:
                          SizedBox(height: 5),

                          Text(widget.tithi,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // ),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Nakshatra',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          // Expanded(
                          //   child:
                          SizedBox(height: 5),

                          Text(widget.nakshatra,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          // ),
                          // Text(widget.nakshatra,
                          //     // textAlign: TextAlign.justify,
                          //     style: TextStyle(
                          //         fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                          Text('Karana',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 162, 56, 7),
                              )),
                          SizedBox(height: 5),
                          Text(widget.karana,
                              // textAlign: TextAlign.justify,
                              style: TextStyle(
                                  // fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 162, 56, 7))),
                          Divider(
                            color: Color.fromARGB(255, 255, 192, 2),
                            thickness: 1.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ),
            // SizedBox(height: 10),
            Divider(
              color: Color.fromARGB(255, 255, 192, 2),
              // color: Color.fromARGB(255, 207, 93, 40),
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
                              SizedBox(height: 5),
                              // Divider(
                              //   color: Color.fromARGB(255, 255, 192, 2),
                              //   thickness: 1.0,
                              // ),
                              Text(
                                widget.vishesha,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                // sunriseSunset.sunrise.toString()
                              ),
                            ],
                          )),
                    ])),
          ]),
        ),
      ),
    );
  }
}
