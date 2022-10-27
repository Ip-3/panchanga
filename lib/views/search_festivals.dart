import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:panchanga/models/festival_model.dart';

// ignore: must_be_immutable
class SearchFestival extends StatefulWidget {
  final List<FestivalModel> festivalslistmodel;
  SearchFestival({Key? key, required this.festivalslistmodel})
      : super(key: key);

  // SearchFestival(this.festivalslistmodel);

  @override
  State<SearchFestival> createState() => _SearchFestivalState();
}

class _SearchFestivalState extends State<SearchFestival> {
  // late Future<List<FestivalModel>> shows;
  // List<FestivalModel> shows = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'];

  String searchAradane = "";
  var dateIndex = DateTime.now();

  //  var dateIndex;
  // @override
  // void initState() {
  //   super.initState();

  // @override
  // void initState() {
  //   super.initState();
  //   dateIndex = {widget.festivalslistmodel};
  // }

  // }
  //  if (day.date == updatedDay.date &&
  //           day.month == updatedDay.month &&
  //           day.year == updatedDay.year) {
  //         // print("Compare two list data");
  //         // panchangalistmodel.add(updatedDay);
  //         print(updatedDay.date);
  //         print(updatedDay.month);
  //         print(updatedDay.year);
  //         print(updatedDay.rutu);
  //         panchangalistmodel.remove(day);
  //         panchangalistmodel.add(updatedDay);
  //       }

  @override
  Widget build(BuildContext context) {
    // print(widget.festivalslistmodel);
    // print(widget.festivalslistmodel.month);
    // print(widget.festivalslistmodel.year);
    // List<int> dateList = [dateIndex.day, dateIndex.month, dateIndex.year];

    // for (var i = 0; i < widget.festivalslistmodel.length; i++) {
    //   if (widget.festivalslistmodel[i].date == dateList[0] &&
    //       widget.festivalslistmodel[i].month == dateList[1] &&
    //       widget.festivalslistmodel[i].year == dateList[2]) {}
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Festival',
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
                  // builder: (context, AsyncSnapshot<List<FestivalModel>> snapshot) {
                  // if (snapshot.hasData) {
                  // return
                  Center(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: widget.festivalslistmodel.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.festivalslistmodel[index].festivals
                        .toLowerCase()
                        .contains(searchAradane)
                    ? ListTile(
                        focusColor: Colors.amber,
                        // selectedColor: Colors.amber,
                        // iconColor: Colors.blue,
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        title: Text(
                            '${widget.festivalslistmodel[index].festivals}'),
                        subtitle: Text(
                            'Date: ${widget.festivalslistmodel[index].date}/${widget.festivalslistmodel[index].month}/${widget.festivalslistmodel[index].year}'),
                      )
                    : Container();
              },
              separatorBuilder: (BuildContext context, int index) {
                return {widget.festivalslistmodel[index].festivals}
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
