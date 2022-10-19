import 'package:flutter/material.dart';
import 'package:panchanga/models/tarpana_model.dart';

// ignore: must_be_immutable
class SearchTarpana extends StatefulWidget {
  final List<TarpanaModel> tarpanalistmodel;
  SearchTarpana({Key? key, required this.tarpanalistmodel}) : super(key: key);

  // SearchTarpana(this.tarpanalistmodel);

  @override
  State<SearchTarpana> createState() => _SearchTarpanaState();
}

class _SearchTarpanaState extends State<SearchTarpana> {
  String searchAradane = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tarpana",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 247, 206, 73),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchAradane = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child:
                  // FutureBuilder(
                  // builder: (context, AsyncSnapshot<List<TarpanaModel>> snapshot) {
                  // if (snapshot.hasData) {
                  // return
                  Center(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: widget.tarpanalistmodel.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.tarpanalistmodel[index].tarpana
                        .toLowerCase()
                        .contains(searchAradane)
                    ? ListTile(
                        focusColor: Colors.amber,
                        // selectedColor: Colors.amber,
                        // iconColor: Colors.blue,
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        title:
                            Text('${widget.tarpanalistmodel[index].tarpana}'),
                        subtitle: Text(
                            'Date: ${widget.tarpanalistmodel[index].date}'),
                      )
                    : Container();
              },
              separatorBuilder: (BuildContext context, int index) {
                return {widget.tarpanalistmodel[index].tarpana}
                        .toString()
                        .toLowerCase()
                        .contains(searchAradane)
                    ? Divider()
                    : Container();
              },
            ),
          )
              // }
              // else if (snapshot.hasError) {
              //   return Center(child: Text('Something went wrong :('));
              // }
              // return Center(child: CircularProgressIndicator());
              // },
              // future: ,
              // ),
              ),
        ],
      ),
    );
  }
}

// fetchShows() {
// }
