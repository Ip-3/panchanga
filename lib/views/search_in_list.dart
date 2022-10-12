import 'package:flutter/material.dart';
import 'package:panchanga/panchanga_model.dart';

class SearchInList extends SearchDelegate {
  List<Day> panchangaSearchList = <Day>[];
  SearchInList(this.panchangaSearchList);
  List<String> searchResult = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 247, 206, 73),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> allNames = panchangaSearchList
        .map((panchanagaSearch) => (panchanagaSearch.vishesha))
        .toList();

    List<String> allDate = panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.date)
        .toList();
    List<String> allMonth = panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.month)
        .toList();
    List<String> allYear = panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.year)
        .toList();

    print('$allDate\ $allMonth\ $allYear');

    searchResult.clear();
    searchResult = allNames
        .where((element) => element.toLowerCase().startsWith(query))
        .toList();
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          scrollDirection: Axis.vertical,
          children: List.generate(searchResult.length, (index) {
            var item = searchResult[index];
            var date = allDate[index];
            var month = allMonth[index];
            var year = allYear[index];
            return Card(
              color: Color.fromARGB(255, 247, 206, 73),
              child: Row(children: [
                Expanded(
                    child: Text(item,
                        style: TextStyle(
                          fontSize: 15,
                        ))),
                Row(
                  children: [
                    Text(date),
                    Text("/"),
                    Text(month),
                    Text("/"),
                    Text(year),
                  ],
                ),
              ]),
            );
          })),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> allNames = panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.vishesha)
        .toList();
    List<String> allDate = panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.date)
        .toList();
    List<String> allMonth = panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.month)
        .toList();
    List<String> allYear = panchangaSearchList
        .map((panchanagaSearch) => panchanagaSearch.year)
        .toList();

    var suggestion = [];

    final suggestionList = query.isEmpty
        ? suggestion
        : allNames
                .where((element) => element.toLowerCase().startsWith(query))
                .toList() +
            allDate
                .where((element) => element.toLowerCase().startsWith(query))
                .toList() +
            allMonth
                .where((element) => element.toLowerCase().startsWith(query))
                .toList() +
            allYear
                .where((element) => element.toLowerCase().startsWith(query))
                .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          if (query.isEmpty) {
            query = suggestion[index];
          }
        },
        leading: Icon(query.isEmpty ? Icons.history : Icons.search),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.amber),
                onEnter: (event) =>
                    suggestionList[index].substring(0, query.length),
              ),
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
