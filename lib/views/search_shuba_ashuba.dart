import 'package:flutter/material.dart';
import 'package:panchanga/models/shuba_ashuba_model.dart';

// ignore: must_be_immutable
class SearchShubhaAshubha extends StatefulWidget {
  final List<ShubaAshubaModel> shubhaAshubhalistmodel;
  SearchShubhaAshubha({Key? key, required this.shubhaAshubhalistmodel})
      : super(key: key);

  // SearchShubhaAshubha(this.shubhaAshubhalistmodel);

  @override
  State<SearchShubhaAshubha> createState() => _SearchShubhaAshubhaState();
}

class _SearchShubhaAshubhaState extends State<SearchShubhaAshubha> {
  // late Future<List<ShubaAshubaModel>> shows;
  // List<ShubaAshubaModel> shows = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'];

  String searchAradane = "";

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print("${widget.shubhaAshubhalistmodel[1].shubhaAshubha}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shubha / Ashubha ",
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
                  // builder: (context, AsyncSnapshot<List<ShubaAshubaModel>> snapshot) {
                  // if (snapshot.hasData) {
                  // return
                  Center(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: widget.shubhaAshubhalistmodel.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.shubhaAshubhalistmodel[index].shubhaAshubha
                        .toLowerCase()
                        .contains(searchAradane)
                    ? ListTile(
                        focusColor: Colors.amber,
                        // selectedColor: Colors.amber,
                        // iconColor: Colors.blue,
                        textColor: Color.fromARGB(255, 0, 0, 0),
                        title: Text(
                            '${widget.shubhaAshubhalistmodel[index].shubhaAshubha}'),
                        subtitle: Text(
                            'Date: ${widget.shubhaAshubhalistmodel[index].date}/${widget.shubhaAshubhalistmodel[index].month}/${widget.shubhaAshubhalistmodel[index].year}'),
                      )
                    : Container();
              },
              separatorBuilder: (BuildContext context, int index) {
                return {widget.shubhaAshubhalistmodel[index].shubhaAshubha}
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
