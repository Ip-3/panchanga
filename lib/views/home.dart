import 'dart:core';
import 'package:flutter/material.dart';
import 'package:panchanga/models/aradne_model.dart';
import 'package:panchanga/models/ekadashi_model.dart';
import 'package:panchanga/models/festival_model.dart';
import 'package:panchanga/models/panchanaga_language_list.dart';
import 'package:panchanga/views/search_aradhane.dart';
import 'package:panchanga/views/search_ekadashi.dart';
import 'package:panchanga/views/search_festivals.dart';
import 'package:panchanga/views/search_shuba_ashuba.dart';
import 'package:panchanga/views/search_tarpana.dart';
import 'dart:io';
import 'package:panchanga/views/search_in_list.dart';
import 'package:panchanga/models/panchanga_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:panchanga/views/calendar_event.dart';
import 'package:panchanga/models/shuba_ashuba_model.dart';
import 'package:panchanga/models/tarpana_model.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class Panchanga extends StatefulWidget {
  DateTime differenceDate;
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
  var updateWaitBool = false;

  var difference;
  // late Day updatedDay;
  var jsonPanchanga;
  var jsonPanchangaUpdate;

  var jsonAradane;
  var jsonEkadashi;
  var jsonFestivals;
  var jsonShubhaAshubha;
  var jsonTarpana;

  DateTime specificDate = DateTime.now();

  List<Day> panchangalistmodel = <Day>[];
  List<Day> panchangalistmodelUpdate = <Day>[];
  List<Day> updatedEnglishPanchanaga = <Day>[];
  List<Day> updatedKannadaPanchanaga = <Day>[];
  List<Day> updatedMarathiPanchanaga = <Day>[];
  List<Day> updatedTamilPanchanaga = <Day>[];
  List<Day> updatedTeluguPanchanaga = <Day>[];
  List<Day> updatedSanskritPanchanaga = <Day>[];

  List<AradaneModel> aradaneListmodel = <AradaneModel>[];
  List<EkadashiModel> ekadashiListmodel = <EkadashiModel>[];
  List<FestivalModel> festivalsListmodel = <FestivalModel>[];
  List<TarpanaModel> tarpanaListmodel = <TarpanaModel>[];
  List<ShubaAshubaModel> shubhaAshubhaListmodel = <ShubaAshubaModel>[];

  var path;
  File? mySettingsFile;
  Future<Object> get localSettingsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localSettingsFile async {
    path = await localSettingsPath;
    print(path);
    return new File('$path/settings.txt').create(recursive: true);
  }

  Future<Object> get localPathEnglish async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localEnglishFile async {
    path = await localPathEnglish;
    return new File('$path/EnglishLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateEnglishFile async {
    path = await localPathEnglish;
    return new File('$path/updatedDataEnglish.json').create(recursive: true);
  }

  Future<String> get localPathKannada async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localKannadaFile async {
    path = await localPathKannada;
    return new File('$path/KannadaLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateKannadaFile async {
    path = await localPathKannada;
    return new File('$path/updatedDataKannada.json').create(recursive: true);
  }

  Future<String> get localPathMarathi async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localMarathiFile async {
    path = await localPathMarathi;
    return new File('$path/MarathiLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateMarathiFile async {
    path = await localPathMarathi;
    return new File('$path/updatedDataMarathi.json').create(recursive: true);
  }

  Future<String> get localPathTamil async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localTamilFile async {
    path = await localPathTamil;
    return new File('$path/TamilLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateTamilFile async {
    path = await localPathTamil;
    return new File('$path/updatedDataTamil.json').create(recursive: true);
  }

  Future<String> get localPathTelugu async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localTeluguFile async {
    path = await localPathTelugu;
    return new File('$path/TeluguLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateTeluguFile async {
    path = await localPathTelugu;
    return new File('$path/updatedDataTelugu.json').create(recursive: true);
  }

  Future<String> get localPathSanskrit async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localSanskritFile async {
    path = await localPathSanskrit;
    return new File('$path/SanskritLanguage.json').create(recursive: true);
  }

  Future<File> get localUpdateSanskritFile async {
    path = await localPathSanskrit;
    return new File('$path/updatedDataSanskrit.json').create(recursive: true);
  }

  Future<Object> get localAradanePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localAradaneFile async {
    path = await localSettingsPath;
    print(path);
    return new File('$path/aradane.json').create(recursive: true);
  }

  Future<Object> get localEkadashiPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localEkadashiFile async {
    path = await localSettingsPath;
    print(path);
    return new File('$path/ekadashi.json').create(recursive: true);
  }

  Future<Object> get localFestivalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFestivalFile async {
    path = await localSettingsPath;
    print(path);
    return new File('$path/festivals.json').create(recursive: true);
  }

  Future<Object> get localShubhaAshubhaPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localShubhaAshubhaFile async {
    path = await localSettingsPath;
    print(path);
    return new File('$path/shubhaAshubha.json').create(recursive: true);
  }

  Future<Object> get localTarpanaPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localTarpanaFile async {
    path = await localSettingsPath;
    print(path);
    return new File('$path/tarpana.json').create(recursive: true);
  }

  var appScriptURLEnglish =
      "https://script.google.com/macros/s/AKfycbxHmeYbeP1jolF97VSK6duKpN9W55eKDspbulATBl2dYynq5P04sLi-eu2aTf2PzUMiZg/exec";
  var appScriptURLKannada =
      "https://script.google.com/macros/s/AKfycbwtR-nNrO6tQyHoyiXcyzWjfQkklNKKXRZonq3UL4G8QIlND4uLmjHAi2O0CByZfG4q/exec";
  var appScriptURLTelugu =
      "https://script.google.com/macros/s/AKfycbwPOrs-4OQzAs38KnKODevdbXtD5-5si-FvtEentWfIkv9TMM9ZfVRSOlsVlXr5FCJq/exec";
  var appScriptURLTamil =
      "https://script.google.com/macros/s/AKfycbxdKV4LeYNc6VtJx4sbH6jMCuWIJB5EZ1m5rd-qICoRE2wKzPiCxXnXSITUg8nKnArj/exec";
  var appScriptURLSanskrit =
      "https://script.google.com/macros/s/AKfycbxnEqU15RPW7p3PX-TcSLJSAP0jFCjPcXJou3SY-bU3l6F_n3GJswBeh1POTI_q1Q22/exec";
  var appScriptURLMarathi =
      "https://script.google.com/macros/s/AKfycbyJIdLSgvr8oQ68P7W-AwMmEuDCpEhJ6cKOFTDs9xprBP4VoYlYDgmODTpNf1ygmov0/exec";

  var appScriptURLAradane =
      "https://script.google.com/macros/s/AKfycbwEn4e7isUiI40pmokWOcs6BZMWVBU3Xo4ninvw-jmWxjiSwGCRic5LeGBh3Np8jpj8/exec";
  var appScriptURLTarpana =
      "https://script.google.com/macros/s/AKfycbzU_d_5bBhL_l3p5zsWWhqWl7HB9pC-fw3HXCNQWhW4QCQVQAnoYBVNr7isye3cj0kuww/exec";
  var appScriptURLShubhaAshubha =
      "https://script.google.com/macros/s/AKfycbwubuWuig57hEq7k_JrJz61F5AjgHkJqBwB73j5ZKAcpCoZ20tN6dZclnRAPdQP82EF/exec";
  var appScriptURLFestival =
      "https://script.google.com/macros/s/AKfycby1QilA7Y3kX-9tj1_RjY7kaCuENlhP5C1L7X_qqOg-UN7vjdYYtBHmKgOHARryC0lOwg/exec";
  var appScriptURLEkadashi =
      "https://script.google.com/macros/s/AKfycbxfkiskFlNiUw4GWH7kOrQMOaMXTBx4lYdbfDeZUbMkJtACoaSCfFfmmTojPN0v4fIMTQ/exec";

  List<String> kannadaList = [
    'ಆಯನ',
    'ಋತು',
    'ಮಾಸ',
    'ಮಾಸ ನಿಯಮಕ',
    'ಪಕ್ಷ',
    'ತಿಥಿ',
    'ವಾಸರ',
    'ನಕ್ಷತ್ರ',
    'ಯೋಗ',
    'ಕರಣ',
    'ಇಂದಿನ ವಿಶೇಷ'
  ];

  List<String> englishList = [
    'Ayana',
    'Rutu',
    'Masa',
    'Masa Niyamaka',
    'Paksha',
    'Tithi',
    'Vasara',
    'Nakshatra',
    'Yoga',
    'Karana',
    "Today's special"
  ];

  List<String> marathiList = [
    'अयाना',
    'रुतु',
    'मसा',
    'मासा नियमक',
    'पक्ष',
    'तिथि',
    'वासरां',
    'नक्षत्र',
    'योग',
    'करण',
    "आज के लिए ख़ास"
  ];

  List<String> tamilList = [
    'அயனா',
    'ருது',
    'மாசா',
    'மாச நியமகா',
    'பக்ஷா',
    'திதி',
    'வாசரா',
    'நக்ஷத்ரா',
    'யோகா',
    'கரண',
    "இன்றைய சிறப்பு"
  ];

  List<String> teluguList = [
    'అయన',
    'రుతు',
    'మాస',
    'మాస నియమక',
    'పక్ష',
    'తిథి',
    'వాసర',
    'నక్షత్రం',
    'యోగా',
    'కరణ',
    "నేటి ప్రత్యేకత"
  ];

  List<PanchanagaLanguageList> allLanguageList = <PanchanagaLanguageList>[];

  getKannadaList() async {
    allLanguageList.clear();

    PanchanagaLanguageList panchanagaLanguageList = new PanchanagaLanguageList(
      languageListayana: '',
      languageListkarana: '',
      languageListmasaniyamaka: '',
      languageListnakshatra: '',
      languageListrutu: '',
      languageListmasa: '',
      languageListvasara: '',
      languageListtithi: '',
      languageListvishesha: '',
      languageListyoga: '',
      languageListpaksha: '',
    );
    for (int i = 0; i < kannadaList.length; i++) {
      panchanagaLanguageList.languageListayana = kannadaList[0];
      panchanagaLanguageList.languageListpaksha = kannadaList[4];
      panchanagaLanguageList.languageListrutu = kannadaList[1];
      panchanagaLanguageList.languageListmasa = kannadaList[2];
      panchanagaLanguageList.languageListmasaniyamaka = kannadaList[3];
      panchanagaLanguageList.languageListvasara = kannadaList[6];
      panchanagaLanguageList.languageListnakshatra = kannadaList[7];
      panchanagaLanguageList.languageListtithi = kannadaList[5];
      panchanagaLanguageList.languageListyoga = kannadaList[8];
      panchanagaLanguageList.languageListkarana = kannadaList[9];
      panchanagaLanguageList.languageListvishesha = kannadaList[10];
      allLanguageList.add(panchanagaLanguageList);
    }
  }

  getEnglishList() async {
    // kannadaList.forEach((element) {
    //   print('Macha bari erlemet');
    //   print(element);
    // });
    allLanguageList.clear();

    PanchanagaLanguageList panchanagaLanguageList = new PanchanagaLanguageList(
      languageListayana: '',
      languageListkarana: '',
      languageListmasaniyamaka: '',
      languageListnakshatra: '',
      languageListrutu: '',
      languageListmasa: '',
      languageListvasara: '',
      languageListtithi: '',
      languageListvishesha: '',
      languageListyoga: '',
      languageListpaksha: '',
    );
    // print("maga element $element");
    for (int i = 0; i < englishList.length; i++) {
      panchanagaLanguageList.languageListayana = englishList[0];
      panchanagaLanguageList.languageListpaksha = englishList[4];
      panchanagaLanguageList.languageListrutu = englishList[1];
      panchanagaLanguageList.languageListmasa = englishList[2];
      panchanagaLanguageList.languageListmasaniyamaka = englishList[3];
      panchanagaLanguageList.languageListvasara = englishList[6];
      panchanagaLanguageList.languageListnakshatra = englishList[7];
      panchanagaLanguageList.languageListtithi = englishList[5];
      panchanagaLanguageList.languageListyoga = englishList[8];
      panchanagaLanguageList.languageListkarana = englishList[9];
      panchanagaLanguageList.languageListvishesha = englishList[10];
      allLanguageList.add(panchanagaLanguageList);
    }
  }

  getMarathiList() async {
    // kannadaList.forEach((element) {
    //   print('Macha bari erlemet');
    //   print(element);
    // });
    allLanguageList.clear();

    PanchanagaLanguageList panchanagaLanguageList = new PanchanagaLanguageList(
      languageListayana: '',
      languageListkarana: '',
      languageListmasaniyamaka: '',
      languageListnakshatra: '',
      languageListrutu: '',
      languageListmasa: '',
      languageListvasara: '',
      languageListtithi: '',
      languageListvishesha: '',
      languageListyoga: '',
      languageListpaksha: '',
    );
    // print("maga element $element");
    for (int i = 0; i < marathiList.length; i++) {
      panchanagaLanguageList.languageListayana = marathiList[0];
      panchanagaLanguageList.languageListpaksha = marathiList[4];
      panchanagaLanguageList.languageListrutu = marathiList[1];
      panchanagaLanguageList.languageListmasa = marathiList[2];
      panchanagaLanguageList.languageListmasaniyamaka = marathiList[3];
      panchanagaLanguageList.languageListvasara = marathiList[6];
      panchanagaLanguageList.languageListnakshatra = marathiList[7];
      panchanagaLanguageList.languageListtithi = marathiList[5];
      panchanagaLanguageList.languageListyoga = marathiList[8];
      panchanagaLanguageList.languageListkarana = marathiList[9];
      panchanagaLanguageList.languageListvishesha = marathiList[10];
      allLanguageList.add(panchanagaLanguageList);
    }
  }

  getSanskritList() async {
    // kannadaList.forEach((element) {
    //   print('Macha bari erlemet');
    //   print(element);
    // });
    allLanguageList.clear();

    PanchanagaLanguageList panchanagaLanguageList = new PanchanagaLanguageList(
      languageListayana: '',
      languageListkarana: '',
      languageListmasaniyamaka: '',
      languageListnakshatra: '',
      languageListrutu: '',
      languageListmasa: '',
      languageListvasara: '',
      languageListtithi: '',
      languageListvishesha: '',
      languageListyoga: '',
      languageListpaksha: '',
    );
    // print("maga element $element");
    for (int i = 0; i < marathiList.length; i++) {
      panchanagaLanguageList.languageListayana = marathiList[0];
      panchanagaLanguageList.languageListpaksha = marathiList[4];
      panchanagaLanguageList.languageListrutu = marathiList[1];
      panchanagaLanguageList.languageListmasa = marathiList[2];
      panchanagaLanguageList.languageListmasaniyamaka = marathiList[3];
      panchanagaLanguageList.languageListvasara = marathiList[6];
      panchanagaLanguageList.languageListnakshatra = marathiList[7];
      panchanagaLanguageList.languageListtithi = marathiList[5];
      panchanagaLanguageList.languageListyoga = marathiList[8];
      panchanagaLanguageList.languageListkarana = marathiList[9];
      panchanagaLanguageList.languageListvishesha = marathiList[10];
      allLanguageList.add(panchanagaLanguageList);
    }
  }

  getTeluguList() async {
    // print("maga ili Telugu list");
    // kannadaList.forEach((element) {
    //   print('Macha bari erlemet');
    //   print(element);
    // });
    allLanguageList.clear();
    PanchanagaLanguageList panchanagaLanguageList = new PanchanagaLanguageList(
      languageListayana: '',
      languageListkarana: '',
      languageListmasaniyamaka: '',
      languageListnakshatra: '',
      languageListrutu: '',
      languageListmasa: '',
      languageListvasara: '',
      languageListtithi: '',
      languageListvishesha: '',
      languageListyoga: '',
      languageListpaksha: '',
    );
    // print("maga element $element");
    for (int i = 0; i < teluguList.length; i++) {
      panchanagaLanguageList.languageListayana = teluguList[0];
      panchanagaLanguageList.languageListpaksha = teluguList[4];
      panchanagaLanguageList.languageListrutu = teluguList[1];
      panchanagaLanguageList.languageListmasa = teluguList[2];
      panchanagaLanguageList.languageListmasaniyamaka = teluguList[3];
      panchanagaLanguageList.languageListvasara = teluguList[6];
      panchanagaLanguageList.languageListnakshatra = teluguList[7];
      panchanagaLanguageList.languageListtithi = teluguList[5];
      panchanagaLanguageList.languageListyoga = teluguList[8];
      panchanagaLanguageList.languageListkarana = teluguList[9];
      panchanagaLanguageList.languageListvishesha = teluguList[10];
      allLanguageList.add(panchanagaLanguageList);
    }
  }

  getTamilList() async {
    // kannadaList.forEach((element) {
    //   print('Macha bari erlemet');
    //   print(element);
    // });
    allLanguageList.clear();

    PanchanagaLanguageList panchanagaLanguageList = new PanchanagaLanguageList(
      languageListayana: '',
      languageListkarana: '',
      languageListmasaniyamaka: '',
      languageListnakshatra: '',
      languageListrutu: '',
      languageListmasa: '',
      languageListvasara: '',
      languageListtithi: '',
      languageListvishesha: '',
      languageListyoga: '',
      languageListpaksha: '',
    );
    // print("maga element $element");
    for (int i = 0; i < tamilList.length; i++) {
      panchanagaLanguageList.languageListayana = tamilList[0];
      panchanagaLanguageList.languageListpaksha = tamilList[4];
      panchanagaLanguageList.languageListrutu = tamilList[1];
      panchanagaLanguageList.languageListmasa = tamilList[2];
      panchanagaLanguageList.languageListmasaniyamaka = tamilList[3];
      panchanagaLanguageList.languageListvasara = tamilList[6];
      panchanagaLanguageList.languageListnakshatra = tamilList[7];
      panchanagaLanguageList.languageListtithi = tamilList[5];
      panchanagaLanguageList.languageListyoga = tamilList[8];
      panchanagaLanguageList.languageListkarana = tamilList[9];
      panchanagaLanguageList.languageListvishesha = tamilList[10];
      allLanguageList.add(panchanagaLanguageList);
    }
  }

  getEnglishPanchanga() async {
    print("getEnglishPanchanga");
    langSettingsValue = 1;
    getEnglishList();
    File? myfile;
    File? myUpdatedfile;
    myfile = await localEnglishFile;
    myUpdatedfile = await localUpdateEnglishFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      // print(
      //     "Original English File and Modified English files both are present");
      if (updatedContents.isEmpty == true) {
        // jsonPanchangaUpdate = {};
      } else {
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        getAradaneData();
        getEkadashiData();
        getShubhaAshubhaData();
        getFestivalsData();
        getTarpanData();

        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedEnglishLanguageData();
          // getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      // print(
      //     "Original English File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLEnglish));
      jsonPanchanga = await convert.jsonDecode(raw.body);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
      setState(() {
        getPanchangaDataFromSheet();
        // getAradaneDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    }
    if (updatelanguage == true) {
      // print("Update Pressed getting Modified English files from Remote");
      if (contents.isEmpty == false && updatedContents.isEmpty == true) {
        // print("Updated File is empty");

        getEnglishUpdateCompare();
      } else {
        // print("Updated File is not empty");
        jsonPanchanga = convert.jsonDecode(contents);
        setState(() {
          panchangalistmodel.clear();
          getPanchangaDataFromSheet();
        });
      }
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      // print("Just show Original English File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
      setState(() {
        panchangalistmodel.clear();
        getPanchangaDataFromSheet();
      });
    }
  }

  getEnglishUpdateCompare() async {
    File? myUpdatedfile;
    myUpdatedfile = await localUpdateEnglishFile;
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
      panchangalistmodelUpdate.clear();
      panchangalistmodel.clear();
      getUpdatedEnglishLanguageData();
      // getUpdateLanguageCompareData();
    });
  }

  getUpdatedEnglishLanguageData() {
    jsonPanchanga.forEach((element2) {
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
      day.date = element2['date'].toString();
      day.month = element2['month'].toString();
      day.year = element2['year'].toString();
      day.samvatsara = element2['samvatsara'].toString();
      day.ayana = element2["ayana"].toString();
      day.paksha = element2["paksha"].toString();
      day.rutu = element2['rutu'].toString();
      day.masa = element2['masa'].toString();
      day.masaniyamaka = element2['masaniyamaka'].toString();
      day.calendarmark = element2['calendarmark'].toString();
      day.vasara = element2["vasara"].toString();
      day.nakshatra = element2['nakshatra'].toString();
      day.tithi = element2['tithi'].toString();
      day.yoga = element2['yoga'].toString();
      day.karana = element2['karana'].toString();
      day.sunrise = element2['sunrise'].toString();
      day.sunset = element2["sunset"].toString();
      day.shradhatithi = element2['shradhatithi'].toString();
      day.vishesha = element2['vishesha'].toString();
      panchangalistmodel.add(day);
      jsonPanchangaUpdate.forEach((element) {
        Day updatedDay = new Day(
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

        if (day.date == updatedDay.date &&
            day.month == updatedDay.month &&
            day.year == updatedDay.year) {
          // print("Compare two list data");
          // panchangalistmodel.add(updatedDay);
          print(updatedDay.date);
          print(updatedDay.month);
          print(updatedDay.year);
          print(updatedDay.rutu);
          panchangalistmodel.remove(day);
          panchangalistmodel.add(updatedDay);
        }
      });
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
        dateIndex = dateDataIndex;
      }
    }
    updateWaitBool = false;
  }

  getKannadaPanchanga() async {
    print("getKannadaPanchanga");
    langSettingsValue = 2;

    getKannadaList();
    File? myfile;
    File? myUpdatedfile;
    myfile = await localKannadaFile;
    myUpdatedfile = await localUpdateKannadaFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      // print(
      //     "Original Kannada File and Modified Kannada files both are present");
      if (updatedContents.isEmpty == true) {
        // print("First fails");
        // jsonPanchangaUpdate = {};
      } else {
        // print("First fails Else");
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        getAradaneData();
        getEkadashiData();
        getShubhaAshubhaData();
        getFestivalsData();
        getTarpanData();
        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedKannadaLanguageData();
          // getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      // print(
      // "Original Kannada File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLKannada));
      jsonPanchanga = convert.jsonDecode(raw.body);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
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
      // print("Update Pressed getting Modified Kannada files from Remote");
      if (contents.isEmpty == false && updatedContents.isEmpty == true) {
        // print("Updated File is empty");
        getKannadaUpdateCompare();
      } else {
        // print("Updated File is not empty");
        jsonPanchanga = convert.jsonDecode(contents);
        setState(() {
          panchangalistmodel.clear();
          getPanchangaDataFromSheet();
        });
      }
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      // print("Just show Original Kannada File from local database");

      jsonPanchanga = convert.jsonDecode(contents);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
      setState(() {
        panchangalistmodel.clear();
        getPanchangaDataFromSheet();
      });
    }
  }

  getKannadaUpdateCompare() async {
    File? myUpdatedfile;
    myUpdatedfile = await localUpdateKannadaFile;
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
      panchangalistmodelUpdate.clear();
      panchangalistmodel.clear();
      getUpdatedKannadaLanguageData();
      // getUpdateLanguageCompareData();
    });
  }

  getUpdatedKannadaLanguageData() {
    jsonPanchanga.forEach((element2) {
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
      day.date = element2['date'].toString();
      day.month = element2['month'].toString();
      day.year = element2['year'].toString();
      day.samvatsara = element2['samvatsara'].toString();
      day.ayana = element2["ayana"].toString();
      day.paksha = element2["paksha"].toString();
      day.rutu = element2['rutu'].toString();
      day.masa = element2['masa'].toString();
      day.masaniyamaka = element2['masaniyamaka'].toString();
      day.calendarmark = element2['calendarmark'].toString();
      day.vasara = element2["vasara"].toString();
      day.nakshatra = element2['nakshatra'].toString();
      day.tithi = element2['tithi'].toString();
      day.yoga = element2['yoga'].toString();
      day.karana = element2['karana'].toString();
      day.sunrise = element2['sunrise'].toString();
      day.sunset = element2["sunset"].toString();
      day.shradhatithi = element2['shradhatithi'].toString();
      day.vishesha = element2['vishesha'].toString();
      panchangalistmodel.add(day);
      jsonPanchangaUpdate.forEach((element) {
        Day updatedDay = new Day(
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

        if (day.date == updatedDay.date &&
            day.month == updatedDay.month &&
            day.year == updatedDay.year) {
          // print("Compare two list data");
          // panchangalistmodel.add(updatedDay);
          print(updatedDay.date);
          print(updatedDay.month);
          print(updatedDay.year);
          print(updatedDay.rutu);
          panchangalistmodel.remove(day);
          panchangalistmodel.add(updatedDay);
        }
      });
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
        dateIndex = dateDataIndex;
      }
    }
    updateWaitBool = false;
  }

  getMarathiPanchanga() async {
    print("getMarathiPanchanga");
    langSettingsValue = 3;

    getMarathiList();
    File? myfile;
    File? myUpdatedfile;
    myfile = await localMarathiFile;
    myUpdatedfile = await localUpdateMarathiFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      // print(
      // "Original Marathi File and Modified Marathi files both are present");
      if (updatedContents.isEmpty == true) {
        // print("First fails");
        // jsonPanchangaUpdate = {};
      } else {
        // print("First fails Else");
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        getAradaneData();
        getEkadashiData();
        getShubhaAshubhaData();
        getFestivalsData();
        getTarpanData();
        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedMarathiLanguageData();
          // getUpdateLanguageCompareData();
        });
      }
    }
    if (contents.isEmpty == true) {
      // print(
      // "Original Marathi File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLMarathi));
      jsonPanchanga = convert.jsonDecode(raw.body);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
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
      // print("Update Pressed getting Modified Marathi files from Remote");
      if (contents.isEmpty == false && updatedContents.isEmpty == true) {
        // print("Updated File is empty");
        getMarathiUpdateCompare();
      } else {
        // print("Updated File is not empty");
        jsonPanchanga = convert.jsonDecode(contents);
        setState(() {
          panchangalistmodel.clear();
          getPanchangaDataFromSheet();
        });
      }
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      // print("Just show Original Marathi File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
      setState(() {
        panchangalistmodel.clear();
        getPanchangaDataFromSheet();
      });
    }
  }

  getMarathiUpdateCompare() async {
    File? myUpdatedfile;
    myUpdatedfile = await localUpdateMarathiFile;
    var request = appScriptURLMarathi + "?aaa=hit";
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
      panchangalistmodelUpdate.clear();
      panchangalistmodel.clear();
      getUpdatedMarathiLanguageData();
      // getUpdateLanguageCompareData();
    });
  }

  getUpdatedMarathiLanguageData() {
    jsonPanchanga.forEach((element2) {
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
      day.date = element2['date'].toString();
      day.month = element2['month'].toString();
      day.year = element2['year'].toString();
      day.samvatsara = element2['samvatsara'].toString();
      day.ayana = element2["ayana"].toString();
      day.paksha = element2["paksha"].toString();
      day.rutu = element2['rutu'].toString();
      day.masa = element2['masa'].toString();
      day.masaniyamaka = element2['masaniyamaka'].toString();
      day.calendarmark = element2['calendarmark'].toString();
      day.vasara = element2["vasara"].toString();
      day.nakshatra = element2['nakshatra'].toString();
      day.tithi = element2['tithi'].toString();
      day.yoga = element2['yoga'].toString();
      day.karana = element2['karana'].toString();
      day.sunrise = element2['sunrise'].toString();
      day.sunset = element2["sunset"].toString();
      day.shradhatithi = element2['shradhatithi'].toString();
      day.vishesha = element2['vishesha'].toString();
      panchangalistmodel.add(day);
      jsonPanchangaUpdate.forEach((element) {
        Day updatedDay = new Day(
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

        if (day.date == updatedDay.date &&
            day.month == updatedDay.month &&
            day.year == updatedDay.year) {
          // print("Compare two list data");
          // panchangalistmodel.add(updatedDay);
          print(updatedDay.date);
          print(updatedDay.month);
          print(updatedDay.year);
          print(updatedDay.rutu);
          panchangalistmodel.remove(day);
          panchangalistmodel.add(updatedDay);
        }
      });
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
        dateIndex = dateDataIndex;
      }
    }
    updateWaitBool = false;
  }

  getTamilPanchanga() async {
    print("getTamilPanchanga");
    langSettingsValue = 4;

    getTamilList();
    File? myfile;
    File? myUpdatedfile;
    myfile = await localTamilFile;
    myUpdatedfile = await localUpdateTamilFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      // print("Original Tamil File and Modified Tamil files both are present");
      if (updatedContents.isEmpty == true) {
        // print("First fails");
        // jsonPanchangaUpdate = {};
      } else {
        // print("First fails Else");
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        getAradaneData();
        getEkadashiData();
        getShubhaAshubhaData();
        getFestivalsData();
        getTarpanData();
        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedTamilLanguageData();
        });
      }
    }
    if (contents.isEmpty == true) {
      // print(
      // "Original Tamil File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLTamil));
      jsonPanchanga = convert.jsonDecode(raw.body);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
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
      // print("Update Pressed getting Modified Tamil files from Remote");
      if (contents.isEmpty == false && updatedContents.isEmpty == true) {
        // print("Updated File is empty");
        getTamilUpdateCompare();
      } else {
        // print("Updated File is not empty");
        jsonPanchanga = convert.jsonDecode(contents);
        setState(() {
          panchangalistmodel.clear();
          getPanchangaDataFromSheet();
        });
      }
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      // print("Just show Original Tamil File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
      setState(() {
        panchangalistmodel.clear();
        getPanchangaDataFromSheet();
      });
    }
  }

  getTamilUpdateCompare() async {
    File? myUpdatedfile;
    myUpdatedfile = await localUpdateTamilFile;
    var request = appScriptURLTamil + "?aaa=hit";
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
      panchangalistmodelUpdate.clear();
      panchangalistmodel.clear();
      getUpdatedTamilLanguageData();
      // getUpdateLanguageCompareData();
    });
  }

  getUpdatedTamilLanguageData() {
    jsonPanchanga.forEach((element2) {
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
      day.date = element2['date'].toString();
      day.month = element2['month'].toString();
      day.year = element2['year'].toString();
      day.samvatsara = element2['samvatsara'].toString();
      day.ayana = element2["ayana"].toString();
      day.paksha = element2["paksha"].toString();
      day.rutu = element2['rutu'].toString();
      day.masa = element2['masa'].toString();
      day.masaniyamaka = element2['masaniyamaka'].toString();
      day.calendarmark = element2['calendarmark'].toString();
      day.vasara = element2["vasara"].toString();
      day.nakshatra = element2['nakshatra'].toString();
      day.tithi = element2['tithi'].toString();
      day.yoga = element2['yoga'].toString();
      day.karana = element2['karana'].toString();
      day.sunrise = element2['sunrise'].toString();
      day.sunset = element2["sunset"].toString();
      day.shradhatithi = element2['shradhatithi'].toString();
      day.vishesha = element2['vishesha'].toString();
      panchangalistmodel.add(day);
      jsonPanchangaUpdate.forEach((element) {
        Day updatedDay = new Day(
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

        if (day.date == updatedDay.date &&
            day.month == updatedDay.month &&
            day.year == updatedDay.year) {
          // print("Compare two list data");
          // panchangalistmodel.add(updatedDay);
          print(updatedDay.date);
          print(updatedDay.month);
          print(updatedDay.year);
          print(updatedDay.rutu);
          panchangalistmodel.remove(day);
          panchangalistmodel.add(updatedDay);
        }
      });
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
        dateIndex = dateDataIndex;
      }
    }
    updateWaitBool = false;
  }

  getTeluguPanchanga() async {
    print("getTeluguPanchanga");
    langSettingsValue = 5;
    getTeluguList();
    File? myfile;
    File? myUpdatedfile;
    myfile = await localTeluguFile;
    myUpdatedfile = await localUpdateTeluguFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      // print("Original Telugu File and Modified Telugu files both are present");
      if (updatedContents.isEmpty == true) {
        // print("First fails");
      } else {
        // print("First fails Else");
        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        getAradaneData();
        getEkadashiData();
        getShubhaAshubhaData();
        getFestivalsData();
        getTarpanData();
        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedTeluguLanguageData();
        });
      }
    }
    if (contents.isEmpty == true) {
      // print(
      // "Original Telugu File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLTelugu));
      jsonPanchanga = convert.jsonDecode(raw.body);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
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
      // print("Update Pressed getting Modified Telugu files from Remote");
      if (contents.isEmpty == false && updatedContents.isEmpty == true) {
        // print("Updated File is empty");
        getTeluguUpdateCompare();
      } else {
        // print("Updated File is not empty");
        jsonPanchanga = convert.jsonDecode(contents);
        setState(() {
          panchangalistmodel.clear();
          getPanchangaDataFromSheet();
        });
      }
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      // print("Just show Original Telugu File from local database");
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
      jsonPanchanga = convert.jsonDecode(contents);
      setState(() {
        panchangalistmodel.clear();
        getPanchangaDataFromSheet();
      });
    }
  }

  getTeluguUpdateCompare() async {
    File? myUpdatedfile;
    myUpdatedfile = await localUpdateTeluguFile;
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
      panchangalistmodelUpdate.clear();
      panchangalistmodel.clear();
      getUpdatedTeluguLanguageData();
      // getUpdateLanguageCompareData();
    });
  }

  getUpdatedTeluguLanguageData() {
    jsonPanchanga.forEach((element2) {
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
      day.date = element2['date'].toString();
      day.month = element2['month'].toString();
      day.year = element2['year'].toString();
      day.samvatsara = element2['samvatsara'].toString();
      day.ayana = element2["ayana"].toString();
      day.paksha = element2["paksha"].toString();
      day.rutu = element2['rutu'].toString();
      day.masa = element2['masa'].toString();
      day.masaniyamaka = element2['masaniyamaka'].toString();
      day.calendarmark = element2['calendarmark'].toString();
      day.vasara = element2["vasara"].toString();
      day.nakshatra = element2['nakshatra'].toString();
      day.tithi = element2['tithi'].toString();
      day.yoga = element2['yoga'].toString();
      day.karana = element2['karana'].toString();
      day.sunrise = element2['sunrise'].toString();
      day.sunset = element2["sunset"].toString();
      day.shradhatithi = element2['shradhatithi'].toString();
      day.vishesha = element2['vishesha'].toString();
      panchangalistmodel.add(day);
      jsonPanchangaUpdate.forEach((element) {
        Day updatedDay = new Day(
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

        if (day.date == updatedDay.date &&
            day.month == updatedDay.month &&
            day.year == updatedDay.year) {
          // print("Compare two list data");
          // panchangalistmodel.add(updatedDay);
          print(updatedDay.date);
          print(updatedDay.month);
          print(updatedDay.year);
          print(updatedDay.rutu);
          panchangalistmodel.remove(day);
          panchangalistmodel.add(updatedDay);
        }
      });
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
        dateIndex = dateDataIndex;
      }
    }
    updateWaitBool = false;
  }

  getSanskritPanchanga() async {
    print("getSanskritPanchanga");
    langSettingsValue = 6;

    getSanskritList();
    File? myfile;
    File? myUpdatedfile;
    myfile = await localSanskritFile;
    myUpdatedfile = await localUpdateSanskritFile;
    String? contents = await myfile.readAsString();
    String? updatedContents = await myUpdatedfile.readAsString();
    if (contents.isEmpty == false && updatedContents.isEmpty == false) {
      // print(
      // "Original Sanskrit File and Modified Sanskrit files both are present");
      if (updatedContents.isEmpty == true) {
        // print("First fails");
      } else {
        // print("First fails Else");

        jsonPanchanga = convert.jsonDecode(contents);
        jsonPanchangaUpdate = convert.jsonDecode(updatedContents);
        getAradaneData();
        getEkadashiData();
        getShubhaAshubhaData();
        getFestivalsData();
        getTarpanData();
        setState(() {
          panchangalistmodel.clear();
          panchangalistmodelUpdate.clear();
          getUpdatedSanskritLanguageData();
        });
      }
    }
    if (contents.isEmpty == true) {
      // print(
      // "Original Sanskrit File is not present in Local database, Fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLSanskrit));
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
      // print("Update Pressed getting Modified Sanskrit files from Remote");
      if (contents.isEmpty == false && updatedContents.isEmpty == true) {
        // print("Updated File is empty");
        getSanskritUpdateCompare();
      } else {
        // print("Updated File is not empty");
        jsonPanchanga = convert.jsonDecode(contents);
        setState(() {
          panchangalistmodel.clear();
          getPanchangaDataFromSheet();
        });
      }
    }
    if (contents.isEmpty == false && updatedContents.isEmpty == true) {
      // print("Just show Original Sanskrit File from local database");
      jsonPanchanga = convert.jsonDecode(contents);
      getAradaneData();
      getEkadashiData();
      getShubhaAshubhaData();
      getFestivalsData();
      getTarpanData();
      setState(() {
        panchangalistmodel.clear();
        getPanchangaDataFromSheet();
      });
    }
  }

  getSanskritUpdateCompare() async {
    File? myUpdatedfile;
    myUpdatedfile = await localUpdateSanskritFile;
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
      panchangalistmodelUpdate.clear();
      panchangalistmodel.clear();
      getUpdatedSanskritLanguageData();
      // getUpdateLanguageCompareData();
    });
  }

  getUpdatedSanskritLanguageData() {
    jsonPanchanga.forEach((element2) {
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
      day.date = element2['date'].toString();
      day.month = element2['month'].toString();
      day.year = element2['year'].toString();
      day.samvatsara = element2['samvatsara'].toString();
      day.ayana = element2["ayana"].toString();
      day.paksha = element2["paksha"].toString();
      day.rutu = element2['rutu'].toString();
      day.masa = element2['masa'].toString();
      day.masaniyamaka = element2['masaniyamaka'].toString();
      day.calendarmark = element2['calendarmark'].toString();
      day.vasara = element2["vasara"].toString();
      day.nakshatra = element2['nakshatra'].toString();
      day.tithi = element2['tithi'].toString();
      day.yoga = element2['yoga'].toString();
      day.karana = element2['karana'].toString();
      day.sunrise = element2['sunrise'].toString();
      day.sunset = element2["sunset"].toString();
      day.shradhatithi = element2['shradhatithi'].toString();
      day.vishesha = element2['vishesha'].toString();
      panchangalistmodel.add(day);
      jsonPanchangaUpdate.forEach((element) {
        Day updatedDay = new Day(
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

        if (day.date == updatedDay.date &&
            day.month == updatedDay.month &&
            day.year == updatedDay.year) {
          // print("Compare two list data");
          // panchangalistmodel.add(updatedDay);
          print(updatedDay.date);
          print(updatedDay.month);
          print(updatedDay.year);
          print(updatedDay.rutu);
          panchangalistmodel.remove(day);
          panchangalistmodel.add(updatedDay);
        }
      });
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
        dateIndex = dateDataIndex;
      }
    }
    updateWaitBool = false;
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

    for (dateDataIndex = 0;
        dateDataIndex < panchangalistmodel.length;
        dateDataIndex++) {
      if (widget.differenceDate.day.toString() ==
              panchangalistmodel[dateDataIndex].date &&
          widget.differenceDate.month.toString() ==
              panchangalistmodel[dateDataIndex].month &&
          widget.differenceDate.year.toString() ==
              panchangalistmodel[dateDataIndex].year) {
        // print('Index of the this date is $dateDataIndex');
        dateIndex = dateDataIndex;
      }
    }
    // print('Testing,$dateDataIndex');
  }

  getAradaneData() async {
    File? myfile;
    myfile = await localAradaneFile;
    String? contents = await myfile.readAsString();
    // print(contents);
    if (contents.isEmpty == true) {
      // print("Aradane data is fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLAradane));
      jsonAradane = convert.jsonDecode(raw.body);
      // setState(() {
      getAradaneDataFromSheet();
      // });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      // print(" Local Aradane data ");

      jsonAradane = convert.jsonDecode(contents);
      getAradaneDataFromSheet();
    }
  }

  getAradaneDataFromSheet() async {
    // print("getAradaneDataFromSheet");
    jsonAradane.forEach((element) {
      AradaneModel aradaneModel = new AradaneModel(
        aradane: '',
        date: '',
      );

      aradaneModel.date = element['date'].toString();
      aradaneModel.aradane = element['aradane'].toString();
      aradaneListmodel.add(aradaneModel);
    });
  }

  getEkadashiData() async {
    File? myfile;
    myfile = await localEkadashiFile;
    String? contents = await myfile.readAsString();

    if (contents.isEmpty == true) {
      // print("Ekadashi data is fetching from Remote Database");

      var raw = await http.get(Uri.parse(appScriptURLEkadashi));
      jsonEkadashi = convert.jsonDecode(raw.body);
      setState(() {
        getEkadashiDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      // print(" Local Ekadashi data ");
      jsonEkadashi = convert.jsonDecode(contents);
      getEkadashiDataFromSheet();
    }
  }

  getEkadashiDataFromSheet() async {
    jsonEkadashi.forEach((element) {
      EkadashiModel ekadashiModel =
          new EkadashiModel(ekadashi: '', date: '', day: '');
      ekadashiModel.day = element['day'].toString();
      ekadashiModel.date = element['date'].toString();
      ekadashiModel.ekadashi = element['ekadashi'].toString();
      ekadashiListmodel.add(ekadashiModel);
    });
  }

  getFestivalsData() async {
    File? myfile;
    myfile = await localFestivalFile;
    String? contents = await myfile.readAsString();
    if (contents.isEmpty == true) {
      // print("Festival data is fetching from Remote Database");

      var raw = await http.get(Uri.parse(appScriptURLFestival));
      jsonFestivals = convert.jsonDecode(raw.body);
      setState(() {
        getFestivalsDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      // print(" Local Festivals data ");

      jsonFestivals = convert.jsonDecode(contents);
      getFestivalsDataFromSheet();
      // getUpdateLanguageCompareData();
      // });
    }
  }

  getFestivalsDataFromSheet() async {
    jsonFestivals.forEach((element) {
      FestivalModel festivalsModel =
          new FestivalModel(festivals: '', date: '', month: '', year: '');
      festivalsModel.month = element['month'].toString();
      festivalsModel.year = element['year'].toString();
      festivalsModel.date = element['date'].toString();
      festivalsModel.festivals = element['festivals'].toString();
      festivalsListmodel.add(festivalsModel);
    });
  }

  getShubhaAshubhaData() async {
    File? myfile;
    myfile = await localShubhaAshubhaFile;
    String? contents = await myfile.readAsString();

    if (contents.isEmpty == true) {
      var raw = await http.get(Uri.parse(appScriptURLShubhaAshubha));
      jsonShubhaAshubha = convert.jsonDecode(raw.body);
      setState(() {
        getShubhaAshubhaDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      // print(" Local Shubha Ashbha data ");

      jsonShubhaAshubha = convert.jsonDecode(contents);
      getShubhaAshubhaDataFromSheet();
    }
  }

  getShubhaAshubhaDataFromSheet() async {
    jsonShubhaAshubha.forEach((element) {
      ShubaAshubaModel shubhaAshubhaModel = new ShubaAshubaModel(
          shubhaAshubha: '', date: '', month: '', year: '');
      shubhaAshubhaModel.date = element['date'].toString();
      shubhaAshubhaModel.month = element['month'].toString();

      shubhaAshubhaModel.year = element['year'].toString();

      shubhaAshubhaModel.shubhaAshubha = element['shubhaAshubha'].toString();
      shubhaAshubhaListmodel.add(shubhaAshubhaModel);
    });
  }

  getTarpanData() async {
    File? myfile;
    myfile = await localTarpanaFile;
    String? contents = await myfile.readAsString();

    if (contents.isEmpty == true) {
      // print("Tarpana data is fetching from Remote Database");
      var raw = await http.get(Uri.parse(appScriptURLTarpana));
      jsonTarpana = convert.jsonDecode(raw.body);
      setState(() {
        getTarpanDataFromSheet();
      });
      String jsondata = raw.body
          .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
        return "'${match.group(0)}'";
      });
      return myfile.writeAsString(jsondata);
    } else {
      // print(" Local Tarpana data ");

      jsonTarpana = convert.jsonDecode(contents);
      getTarpanDataFromSheet();
    }
  }

  getTarpanDataFromSheet() async {
    jsonTarpana.forEach((element) {
      TarpanaModel tarpanaModel = new TarpanaModel(
        tarpana: '',
        date: '',
      );
      tarpanaModel.date = element['date'].toString();
      tarpanaModel.tarpana = element['tarpana'].toString();
      tarpanaListmodel.add(tarpanaModel);
    });
  }

  @override
  void initState() {
    initialState();
    super.initState();
  }

  void initialState() async {
    // rm -rf ./*.tmp
    // allLanguageList.clear();

    mySettingsFile = await localSettingsFile;
    String? contents = (await mySettingsFile?.readAsString());
    if (contents!.isNotEmpty) {
      // print("Its here");
      settingsLanguage = int.parse(contents);
    }
    // allLanguageList.clear();
    // englishList.clear();
    // tamilList.clear();
    // teluguList.clear();
    // marathiList.clear();
    int count = 1;

    switch (settingsLanguage) {
      case 1:
        getEnglishPanchanga();
        // getEnglishList();
        break;
      case 2:
        getKannadaPanchanga();
        // getKannadaList();
        break;
      case 3:
        getMarathiPanchanga();
        // getMarathiList();
        break;
      case 4:
        getTamilPanchanga();
        // getTamilList();
        break;
      case 5:
        getTeluguPanchanga();
        // getTeluguList();
        break;
      case 6:
        getSanskritPanchanga();
        // getSanskritList();
        break;
      default:
        if (count == 1) {
          getSanskritPanchanga();
          // sleep(Duration(milliseconds: 10));
          getMarathiPanchanga();
          // sleep(Duration(milliseconds: 10));
          getTamilPanchanga();
          // sleep(Duration(milliseconds: 10));
          getKannadaPanchanga();
          // sleep(Duration(milliseconds: 10));

          getTeluguPanchanga();
        }
        getEnglishPanchanga();

        // getEnglishList();
        // getTeluguList();
        // getMarathiList();
        // getKannadaList();
        // getSanskritList();
        // getKannadaList();
        getAradaneData();
        getEkadashiData();
        getShubhaAshubhaData();
        getFestivalsData();
        getTarpanData();

        // sleep(Duration(milliseconds: 10));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (updateWaitBool == true) {
      // print("Hereeeeeeeee");
      Future.delayed(Duration(seconds: 3), () {});
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "U M Panchanga",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: false,
          // iconTheme: IconThemeData(color: Color.fromARGB(255, 247, 206, 73)),
          backgroundColor: Color.fromARGB(255, 247, 206, 73),
        ),
        body: Center(
            child: CircularProgressIndicator(
          color: Color.fromARGB(255, 247, 206, 73),
        )),
      );
    }

    if (dateIndex == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "U M Panchanga",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 247, 206, 73)),
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
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "U M Panchanga",
            style: TextStyle(
              color: Color.fromARGB(255, 162, 56, 7),
              fontSize: screenSize.width / 26,
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
                        showSearch(
                            context: context,
                            delegate: SearchInList(panchangalistmodel));
                      },
                    ))),
            nomalPopMenu(),
          ],
        ),
        drawer: Drawer(
          width: screenSize.width / 1.5,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 206, 73),
                  //     image: DecorationImage(
                  //         image: NetworkImage(
                  //           "https://lh5.googleusercontent.com/p/AF1QipPpOk5SBoE7ney7zLqajq77mjYBqueiEFeM5-7T=w1080-k-no",
                  //         ),
                  // fit: BoxFit.cover)
                ),
                child: Text(
                  "Uttaradi Math Panchanga",
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
                  // print(aradaneListmodel);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchAradhane(
                              aradanelistmodel: aradaneListmodel)));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Ekadashi'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchEkadashi(
                              ekadashilistmodel: ekadashiListmodel)));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Festivals / Special days'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchFestival(
                              festivalslistmodel: festivalsListmodel)));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Tarapana'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchTarpana(tarpanalistmodel: tarpanaListmodel)
                          // (CalendarData(data: calendarViewListModel))
                          ));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
              ListTile(
                title: const Text('Shubha / Ashuba'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchShubhaAshubha(
                              shubhaAshubhalistmodel: shubhaAshubhaListmodel)));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 255, 192, 2),
                thickness: 03.0,
              ),
            ],
          ),
        ),
        body: Container(
          // width: screenSize.width,
          // height: screenSize.height,
          child:
              // children: [
              PageView.builder(
                  clipBehavior: Clip.hardEdge,
                  controller: controller,
                  itemCount: panchangalistmodel.length,
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
                      languageListayana: allLanguageList[0].languageListayana,
                      languageListrutu: allLanguageList[1].languageListrutu,
                      languageListmasa: allLanguageList[2].languageListmasa,
                      languageListmasaniyamaka:
                          allLanguageList[3].languageListmasaniyamaka,
                      languageListpaksha: allLanguageList[4].languageListpaksha,
                      languageListtithi: allLanguageList[5].languageListtithi,
                      languageListvasara: allLanguageList[6].languageListvasara,
                      languageListnakshatra:
                          allLanguageList[7].languageListnakshatra,
                      languageListyoga: allLanguageList[8].languageListyoga,
                      languageListkarana: allLanguageList[9].languageListkarana,
                      languageListvishesha:
                          allLanguageList[10].languageListvishesha,
                    );
                  }),

          // ],
        ),
      );
    }
  }

  Widget nomalPopMenu() {
    // Size screenSize = MediaQuery.of(context).size;

    return PopupMenuButton<int>(
      iconSize: 20,
      icon: const Icon(Icons.more_vert, color: Colors.black),
      itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              // fromHeight use double.infinity as width and 40 is the height
            ),
            child: const Text('Language'),
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      color: Color.fromARGB(255, 232, 220, 184),
                      child: Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Select Language'),
                            RadioListTile(
                              title: Text("English"),
                              value: "1",
                              toggleable: true,
                              autofocus: true,
                              enableFeedback: false,
                              groupValue: langValue,
                              onChanged: (value) async {
                                mySettingsFile = await localSettingsFile;
                                mySettingsFile?.writeAsString(value.toString());
                                langValue = value;
                                langSettingsValue = value;
                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                allLanguageList.clear();
                                getEnglishPanchanga();
                                getEnglishList();
                                Navigator.pop(context);
                                // });
                              },
                            ),
                            RadioListTile(
                              title: Text("Kannada"),
                              value: "2",
                              groupValue: langValue,
                              toggleable: true,
                              autofocus: true,
                              onChanged: (value) async {
                                mySettingsFile = await localSettingsFile;
                                mySettingsFile?.writeAsString(value.toString());
                                langValue = value;
                                langSettingsValue = value;
                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                allLanguageList.clear();
                                getKannadaPanchanga();
                                getKannadaList();
                                Navigator.pop(context);
                                // });
                              },
                            ),
                            RadioListTile(
                              title: Text("Marathi"),
                              value: "3",
                              groupValue: langValue,
                              toggleable: true,
                              autofocus: true,
                              onChanged: (value) async {
                                mySettingsFile = await localSettingsFile;
                                mySettingsFile?.writeAsString(value.toString());

                                langValue = value;
                                langSettingsValue = value;
                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                allLanguageList.clear();
                                getMarathiPanchanga();
                                getMarathiList();
                                Navigator.pop(context);
                                // });
                              },
                            ),
                            RadioListTile(
                              title: Text("Tamil"),
                              value: "4",
                              groupValue: langValue,
                              toggleable: true,
                              autofocus: true,
                              onChanged: (value) async {
                                mySettingsFile = await localSettingsFile;
                                mySettingsFile?.writeAsString(value.toString());

                                // await new Future.delayed(
                                //     const Duration(milliseconds: 100));
                                langValue = value;
                                langSettingsValue = value;

                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                allLanguageList.clear();
                                getTamilPanchanga();
                                getTamilList();
                                Navigator.pop(context);
                                // });
                              },
                            ),
                            RadioListTile(
                              title: Text("Telugu"),
                              value: "5",
                              groupValue: langValue,
                              toggleable: true,
                              autofocus: true,
                              onChanged: (value) async {
                                mySettingsFile = await localSettingsFile;
                                mySettingsFile?.writeAsString(value.toString());

                                langValue = value;
                                langSettingsValue = value;
                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                allLanguageList.clear();
                                getTeluguPanchanga();
                                getTeluguList();
                                Navigator.pop(context);
                                // });
                              },
                            ),
                            RadioListTile(
                              title: Text("Sanskrit"),
                              value: "6",
                              groupValue: langValue,
                              toggleable: true,
                              autofocus: true,
                              onChanged: (value) async {
                                mySettingsFile = await localSettingsFile;
                                mySettingsFile?.writeAsString(value.toString());

                                langValue = value;
                                langSettingsValue = value;
                                panchangalistmodel.clear();
                                panchangalistmodelUpdate.clear();
                                allLanguageList.clear();
                                getSanskritPanchanga();
                                getSanskritList();
                                Navigator.pop(context);
                                // });
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Close'),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
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
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              child: const Text('Update'),
              onPressed: () async {
                Navigator.pop(context);
                // showLoaderDialog(context);

                updateWaitBool = true;
                updatelanguage = true;
                File? myUpdatedEnglishFile;
                myUpdatedEnglishFile = await localUpdateEnglishFile;
                String? updatedEnglishContents =
                    await myUpdatedEnglishFile.readAsString();

                File? myUpdatedKannadaFile;
                myUpdatedKannadaFile = await localUpdateKannadaFile;
                String? updatedKannadaContents =
                    await myUpdatedKannadaFile.readAsString();

                File? myUpdatedMarathiFile;
                myUpdatedMarathiFile = await localUpdateMarathiFile;
                String? updatedMarathiContents =
                    await myUpdatedMarathiFile.readAsString();

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
                      getEnglishUpdateCompare();
                      // jsonPanchangaUpdate = {};
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
                      getKannadaUpdateCompare();
                      jsonPanchangaUpdate = {};
                    } else {
                      print("Kannada updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getKannadaPanchanga();
                    }
                    break;
                  case 3:
                    if (updatedMarathiContents.isEmpty == false) {
                      print("Marathi updated file  empty");
                      // jsonPanchangaUpdate = {};
                      getMarathiUpdateCompare();
                    } else {
                      print("Marathi updated file not empty");
                      panchangalistmodel.clear();
                      panchangalistmodelUpdate.clear();
                      getMarathiPanchanga();
                    }
                    break;
                  case 4:
                    if (updatedTamilContents.isEmpty == false) {
                      print("Tamil updated file  empty");
                      // jsonPanchangaUpdate = {};
                      getTamilUpdateCompare();
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
                      // jsonPanchangaUpdate = {};
                      getTeluguUpdateCompare();
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
                      // jsonPanchangaUpdate = {};
                      getSanskritUpdateCompare();
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
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              child: const Text('Exit'),
              onPressed: () {
                Navigator.pop(context);

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
    return PageView(
      scrollDirection: Axis.horizontal,
      reverse: true,
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
          languageListayana: '',
          languageListkarana: '',
          languageListmasaniyamaka: '',
          languageListnakshatra: '',
          languageListrutu: '',
          languageListmasa: '',
          languageListvasara: '',
          languageListtithi: '',
          languageListvishesha: '',
          languageListyoga: '',
          languageListpaksha: '',
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
      vishesha,
      languageListayana,
      languageListrutu,
      languageListmasa,
      languageListmasaniyamaka,
      languageListpaksha,
      languageListtithi,
      languageListvasara,
      languageListnakshatra,
      languageListyoga,
      languageListkarana,
      languageListvishesha;

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
      required this.vishesha,
      required this.languageListayana,
      required this.languageListrutu,
      required this.languageListmasa,
      required this.languageListmasaniyamaka,
      required this.languageListpaksha,
      required this.languageListtithi,
      required this.languageListvasara,
      required this.languageListnakshatra,
      required this.languageListyoga,
      required this.languageListkarana,
      required this.languageListvishesha});

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
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      child: SingleChildScrollView(
        // height: screenSize.height / 2,
        child: Flex(
            // width: screenSize.width,
            // color: Color.fromARGB(255, 245, 240, 225),
            // alignment: Alignment.center,
            direction: Axis.vertical,
            children: [
              Column(children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          Icon(
                            Icons.nightlight_round_outlined,
                            size: 18,
                          ),
                          SizedBox(width: 3),
                          Text(
                            'Sunset',
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
                          SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 255, 192, 2),
                  thickness: 03.0,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.samvatsara,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ] //Samvasthara goes here
                    ),
                Divider(
                  color: Color.fromARGB(255, 255, 192, 2),
                  thickness: 03.0,
                ),
                // SizedBox(height: 15),
                Table(
                  border: TableBorder.all(
                    color: Color.fromARGB(255, 255, 192, 2),
                    width: 1.0,

                    style: BorderStyle.solid,
                    // borderRadius: BorderRadius.circular(50)
                  ),
                  columnWidths: const <int, TableColumnWidth>{
                    // 0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                    // 2: FixedColumnWidth(64),
                  },

                  // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                  // 'Ayana',
                                  widget.languageListayana,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                widget.ayana,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 162, 56, 7),
                                ),
                              ),
                            ),
                            // SizedBox(height: 5),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Column(children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                  // 'Rutu',
                                  widget.languageListrutu,
                                  // textAlign: TextAlign.left,

                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.rutu,
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            // ]),
                          ]),
                    ]),
                    TableRow(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListmasa,
                                  // 'Masa',
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.masa,
                                  // textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Column(children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListmasaniyamaka,
                                  // 'Masa Niyamika',
                                  // textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.masaniyamaka,
                                  // textAlign: TextAlign.justify,
                                  // overflow: TextOverflow.ellipsis,
                                  // maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            // ]),
                          ]),
                    ]),
                    TableRow(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListpaksha,
                                  // 'Paksha',
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.paksha,
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Column(children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListtithi,
                                  // 'Tithi',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text((widget.tithi),
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 162, 56, 7),
                                          )),
                                    ),
                                    Text('(',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          letterSpacing: 3,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 162, 56, 7),
                                        )),
                                    Text(widget.shradhatithi,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          letterSpacing: 3,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 162, 56, 7),
                                        )),
                                    Text(')',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          letterSpacing: 3,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 162, 56, 7),
                                        )),
                                  ],
                                )),
                            // SizedBox(height: 5),
                            // ]),
                          ]),
                    ]),
                    TableRow(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListvasara,
                                  // 'Vasara',
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.vasara,
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Column(children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListnakshatra,
                                  // 'Nakshatra',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.nakshatra,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            // ]),
                          ]),
                    ]),
                    TableRow(children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListyoga,
                                  // 'Yoga',
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                              // SizedBox(height: 5),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.yoga,
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Column(children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.languageListkarana,
                                  // 'Karana',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 162, 56, 7),
                                  )),
                            ),
                            // SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(widget.karana,
                                  // textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 162, 56, 7))),
                              // ]),
                            ),
                            // SizedBox(height: 5),
                          ]),
                    ]),
                  ],
                ),
                // SizedBox(height: 15),
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
                                    widget.languageListvishesha,
                                    // "Today's Special",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.vishesha,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )),
                        ])),
              ]),
            ]),
      ),
    );
  }
}
