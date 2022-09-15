import 'dart:io';
import 'package:flutter/material.dart';
import 'package:panchanga/panchanga_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert' as convert;

// class SearchInList extends SearchDelegate {
//   // var suggestion = ["apple", "ball", "asdf"];

//   // List<String> searchResult = [];
//   List<Day> panchangaSearchList = <Day>[];

//   SearchInList(this.panchangaSearchList);
//   List<String> abcd = <String>[];
//   List<String> searchResult = [];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> allNames = <String>[];
//     // final List<String> allNames =
//     //     panchangaSearchList.map((e) => e.toString()).toList();
//     var suggestion = allNames;
// var pItem;
// List.generate(panchangaSearchList.length, (index) {
//   pItem = panchangaSearchList[index];
//   // print(pItem.vishesha);
//   allNames.add(pItem.vishesha);
// });

//     searchResult.clear();
//     searchResult =
//         allNames.where((element) => element.startsWith(query)).toList();
//     return Container(
//       margin: EdgeInsets.all(20),
//       child:
//       ListView(
//           padding: EdgeInsets.only(top: 8, bottom: 8),
//           scrollDirection: Axis.vertical,
//           children: List.generate(suggestion.length, (index) {
//             var item = suggestion[index];
//             return Card(
//               color: Colors.white,
//               child: Container(padding: EdgeInsets.all(16), child: Text(item),),
//             );
//           })),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> allNames = <String>[];
//     var suggestion = allNames;
//     var pItem;
// List.generate(panchangaSearchList.length, (index) {
//   pItem = panchangaSearchList[index];
//   // print(pItem.vishesha);
//   allNames.add(pItem.vishesha);
// });
//     print(allNames);
//     final suggestionList = query.isEmpty
//         ? suggestion
//         : allNames.where((element) => element.startsWith(query)).toList();
//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         onTap: () {
//           if (query.isEmpty) {
//             query = suggestion[index];
//           }
//         },
//         leading: Icon(query.isEmpty ? Icons.history : Icons.search),
//         title: RichText(
//             text: TextSpan(
//                 text: suggestionList[index].substring(0, query.length),
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                 children: [
//               TextSpan(
//                 text: suggestionList[index].substring(query.length),
//                 style: TextStyle(color: Colors.amber),
//               )
//             ])),
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }

// ignore: must_be_immutable
class SearchInList extends StatefulWidget {
  // SearchInList({required Key key, required this.title}) : super(key: key);
  List<Day> panchangaSearchList = <Day>[];
  SearchInList();
  @override
  _SearchInListState createState() => new _SearchInListState();
}

class _SearchInListState extends State<SearchInList> {
  List<Day> panchangaSearchList = <Day>[];
  List<String> abcd = <String>[];
  TextEditingController editingController = TextEditingController();
  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");

  // var items = List<String>();
  var items = <String>[];
  Future<Object> get localPathEnglish async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  var path;
  Future<File> get localEnglishFile async {
    path = await localPathEnglish;
    // print(path);
    return new File('$path/EnglishLanguage.json').create(recursive: true);
  }

  getList() async {
    File? myUpdatedfile;
    myUpdatedfile = await localEnglishFile;
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
      panchangaSearchList.add(day);
    });
    // print(panchangaSearchList.length);
    // var i;
    // for (i = 0; i < panchangaSearchList.length; i++) {
    //   abcd = panchangaSearchList
    //       .map((panchanagaSearch) => panchanagaSearch.vishesha)
    //       .toList();
    // }
  }

  // final duplicateItems = panchangaSearchList
  //     .map((panchanagaSearch) => panchanagaSearch.vishesha)
  //     .toList();

  @override
  void initState() {
    items.addAll(panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.vishesha)
        .toList());
    getList();
    super.initState();
  }

  void filterSearchResults(String query) {
    // List<String> dummySearchList = List<String>();
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.vishesha)
        .toList());
    if (query.isNotEmpty) {
      // List<String> dummyListData = List<String>();
      List<String> dummyListData = <String>[];

      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(panchangaSearchList
            .map((panchanagaSearch) => panchanagaSearch.vishesha)
            .toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var pItem;
    // List.generate(panchangaSearchList.length, (index) {
    //   pItem = panchangaSearchList[index];
    //   // print(pItem.vishesha);
    //   abcd.add(pItem.vishesha);
    // });
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 247, 206, 73),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
