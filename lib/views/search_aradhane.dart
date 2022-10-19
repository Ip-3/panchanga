import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:panchanga/models/panchanga_model.dart';
import 'package:http/http.dart' as http;
import 'package:panchanga/models/aradne_model.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class SearchAradhane extends StatefulWidget {
  final List<AradaneModel> aradanelistmodel;
  SearchAradhane({Key? key, required this.aradanelistmodel}) : super(key: key);

  // SearchAradhane(this.aradanelistmodel);

  @override
  State<SearchAradhane> createState() => _SearchAradhaneState();
}

class _SearchAradhaneState extends State<SearchAradhane> {
  // late Future<List<AradaneModel>> shows;
  // List<AradaneModel> shows = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'];

  String searchAradane = "";

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print("Search Aradane Class ali bro::: ${widget.aradanelistmodel[1].date}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aradhane',
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
                  // builder: (context, AsyncSnapshot<List<AradaneModel>> snapshot) {
                  // if (snapshot.hasData) {
                  // return
                  Center(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: widget.aradanelistmodel.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.aradanelistmodel[index].aradane
                        .toLowerCase()
                        .contains(searchAradane)
                    ? ListTile(
                        focusColor: Colors.amber,
                        // selectedColor: Colors.amber,
                        // iconColor: Colors.blue,
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        title:
                            Text('${widget.aradanelistmodel[index].aradane}'),
                        subtitle: Text(
                            'Date: ${widget.aradanelistmodel[index].date}'),
                      )
                    : Container();
              },
              separatorBuilder: (BuildContext context, int index) {
                return {widget.aradanelistmodel[index].aradane}
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
