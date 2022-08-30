// import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panchanga/panchanga_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Panchanga extends StatefulWidget {
  @override
  _PanchangaState createState() => _PanchangaState();
}

class _PanchangaState extends State<Panchanga> {
  final Future<Widget> displayDesignWidget = Future<Widget>.delayed(
    const Duration(seconds: 2),
    () => DisplayDesign(),
  );

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File(
        '/Users/pthinks/Documents/Jhenkar/FlutterExamples/panchanga/languageTranslation/EnglishLanguage.json');
  }

  // Future<int> readCounter() async {
  //   try {
  //     final file = await _localFile;
  //     // Read the file
  //     final contents = await file.readAsString();
  //     return int.parse(contents);
  //   } catch (e) {
  //     // If encountering an error, return 0
  //     return 0;
  //   }
  // }

  var output;
  var langValue;

  // ignore: deprecated_member_use
  List<Day> panchangalistmodel = List<Day>();

  var appScriptURLEnglish =
      'https://script.google.com/macros/s/AKfycbzfg606bFaPDAvOD5FMS33-1HO6LjABr9g41aFMSQ/exec';
  var appScriptURLKannada =
      'https://script.google.com/macros/s/AKfycbwIWXVoIZiuvYSlofAoacBDVgJ7ZTeqyxi3DMbTW00Zq1LtELzR_tRRY2q4k9YogabN/exec';
  var appScriptURLTelugu =
      'https://script.google.com/macros/s/AKfycbz_koOsE6hISCYEhc2Z8C9LxNc93lRFTfsdmGVJaenHSh_VHTRoSdUJyUPWl5NMXB6Y/exec';
  var appScriptURLTamil =
      'https://script.google.com/macros/s/AKfycbz_LnGqI3ld0bmR9bRLGChNFa3rFQl27e1zWEDEbbsHiMGXvQRxoVoGf99noPZ0FgP_rw/exec';
  var appScriptURLSanskrit =
      'https://script.google.com/macros/s/AKfycbzH14HdU4qJi0TEt6LBGElfm3coomWeL8DI43mDSOBBChYXmBUZCtnbcaxSg3-s7K1BaQ/exec';
  var appScriptURLHindi =
      'https://script.google.com/macros/s/AKfycbwVmttGzQXMd6RplF8JKIhzI2Rh5Tv2tJe-cgET2-ZfgC-e0pG9xBBrZYy5KgqZIc4D/exec';
  var jsonPanchanga;

  getEnglishPanchanga() async {
    // var raw = await http.get(Uri.parse(appScriptURLEnglish));
    var raw = await rootBundle.loadString(
        "/Users/pthinks/Documents/Jhenkar/FlutterExamples/panchanga/languageTranslation/EnglishLanguage.json");
    // jsonPanchanga = convert.jsonDecode(raw.replaceAll(r'\', r' '));
    // print(jsonPanchanga);
    // var aaa = convert.jsonEncode(raw.body);
    // print(aaa);
    // jsonPanchanga = convert.jsonDecode(raw.body);
    jsonPanchanga = convert.jsonDecode(raw);

    setState(() {
      getPanchangaDataFromSheet();
    });

    // final file = await _localFile;
    // String jsondata = raw.body
    //     .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |,})'), (match) {
    //   return "'${match.group(0)}'";
    // });
    // return file.writeAsString(jsondata);
  }

  getHindiPanchanga() async {
    var raw = await http.get(Uri.parse(appScriptURLHindi));
    jsonPanchanga = convert.jsonDecode(raw.body);
    setState(() {
      getPanchangaDataFromSheet();
    });
  }

  getTamilPanchanga() async {
    var raw = await http.get(Uri.parse(appScriptURLTamil));
    jsonPanchanga = convert.jsonDecode(raw.body);
    setState(() {
      getPanchangaDataFromSheet();
    });
  }

  getTeluguPanchanga() async {
    var raw = await http.get(Uri.parse(appScriptURLTelugu));
    jsonPanchanga = convert.jsonDecode(raw.body);
    setState(() {
      getPanchangaDataFromSheet();
    });
  }

  getSanskritPanchanga() async {
    var raw = await http.get(Uri.parse(appScriptURLSanskrit));
    jsonPanchanga = convert.jsonDecode(raw.body);
    setState(() {
      getPanchangaDataFromSheet();
    });
  }

  getKannadaPanchanga() async {
    var raw = await http.get(Uri.parse(appScriptURLKannada));
    jsonPanchanga = convert.jsonDecode(raw.body);
    setState(() {
      getPanchangaDataFromSheet();
    });
  }

  getPanchangaDataFromSheet() async {
    // var raw = await http.get(Uri.parse(appScriptURLEnglish));
    // jsonPanchanga = convert.jsonDecode(raw.body);
    jsonPanchanga.forEach((element) {
      print('Default English Panchanga List');
      print(element);
      Day day = new Day();
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

      print('${panchangalistmodel[0]}');
    });
  }

  @override
  void initState() {
    // getPanchangaDataFromSheet();
    print("Inside the init");
    print(langValue);
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

  Stream<Widget> aaa = (() async* {
    await Future<Void>.delayed(const Duration(seconds: 5));
    yield DisplayDesign();
  })();

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
      body: StreamBuilder(
          stream: aaa,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return Container(
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
              );
            }
          }),
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
        DisplayDesign(),
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
      {this.date,
      this.month,
      this.year,
      this.samvatsara,
      this.ayana,
      this.rutu,
      this.masa,
      this.masaniyamaka,
      this.paksha,
      this.tithi,
      this.calendarmark,
      this.vasara,
      this.nakshatra,
      this.yoga,
      this.karana,
      this.sunrise,
      this.sunset,
      this.shradhatithi,
      this.vishesha});

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
