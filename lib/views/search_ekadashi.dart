import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:panchanga/models/ekadashi_model.dart';
import 'package:panchanga/models/ekadashi_model.dart';
import 'package:panchanga/models/panchanga_model.dart';
import 'package:http/http.dart' as http;
import 'package:panchanga/models/aradne_model.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class SearchEkadashi extends StatefulWidget {
  final List<EkadashiModel> ekadashilistmodel;
  SearchEkadashi({Key? key, required this.ekadashilistmodel}) : super(key: key);

  // SearchEkadashi(this.ekadashilistmodel);

  @override
  State<SearchEkadashi> createState() => _SearchEkadashiState();
}

class _SearchEkadashiState extends State<SearchEkadashi> {
  // late Future<List<EkadashiModel>> shows;
  // List<EkadashiModel> shows = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'];

  String searchAradane = "";

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ekadashi',
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
                  // builder: (context, AsyncSnapshot<List<EkadashiModel>> snapshot) {
                  // if (snapshot.hasData) {
                  // return
                  Center(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: widget.ekadashilistmodel.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.ekadashilistmodel[index].ekadashi
                        .toLowerCase()
                        .contains(searchAradane)
                    ? ListTile(
                        focusColor: Colors.amber,
                        // selectedColor: Colors.amber,
                        // iconColor: Colors.blue,
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        title:
                            Text('${widget.ekadashilistmodel[index].ekadashi}'),
                        subtitle: Text(
                            'Date: ${widget.ekadashilistmodel[index].date}'),
                      )
                    : Container();
              },
              separatorBuilder: (BuildContext context, int index) {
                return {widget.ekadashilistmodel[index].ekadashi}
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
