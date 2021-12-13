import 'dart:convert';

import 'package:ehr/records.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.my_id}) : super(key: key);
  final my_id;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController ownercontroller = TextEditingController();
  TextEditingController typecontroller = TextEditingController();
  TextEditingController datacontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Read',
                  ),
                  Tab(
                    text: 'Write',
                  ),
                ],
              )
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          // backgroundColor: Colors.green,
          onPressed: () {
            setState(() {});
          },
        ),
        body: TabBarView(
          children: [
            ReadPage(),
            WritePage(),
          ],
        ),
      ),
    );
  }

  ReadPage() {
    return FutureBuilder(
        future: _fetchListItems(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return new ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                String key = snapshot.data.keys.elementAt(index);
                return new Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecordsPage(
                                  pat_id: key,
                                  recds: snapshot.data[key],
                                )));
                      },
                      child: Card(
                        elevation: 0,
                        child: new ListTile(
                          title: new Text("Patient ID: $key"),
                          // subtitle: new Text("${snapshot.data[key]}"),
                        ),
                      ),
                    ),
                    new Divider(
                      height: 2.0,
                    ),
                  ],
                );
              },
            );
          }
        });
  }

  WritePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: ownercontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Owner ID',
              hintText: "Enter Owner's ID",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: typecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Type',
              hintText: "Enter Type of Record",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: datacontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Data',
              hintText: "Enter Owner's Data",
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(30),
          child: FlatButton(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            color: Colors.blueAccent,
            textColor: Colors.white,
            onPressed: () async {
              final response = await http.post(
                  Uri.parse('http://192.168.2.156:8080/api/adddata/'),
                  headers: <String, String>{
                    'Content-Type': 'application/json',
                  },
                  body: jsonEncode(<String, String>{
                    'owner': ownercontroller.text,
                    'type': typecontroller.text,
                    'data': datacontroller.text,
                  }));
              final snackBar = SnackBar(
                content: const Text('Record Created!'),
                // action: SnackBarAction(
                //   label: 'Undo',
                //   onPressed: () {

                //   },
                // ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              // showInSnackBar("Data");
            },
          ),
        ),
      ],
    );
    // return Container(
    //   child: Center(child: Text("Write")),
    // );
  }

  // UpdatePage() {
  //   return Container(
  //     child: Center(child: Text("Update")),
  //   );
  // }

  _fetchListItems() async {
    final response = await http.get(
      // Uri.parse('http://65.1.153.111/api/queryAllbyOwner/'),
      Uri.parse('http://192.168.2.156:8080/api/queryAllbyOwner/'),
    );
    var jsonData = jsonDecode(response.body);
    var values = jsonData['response'];
    // var values = response.data['response'];
    return values;
  }
}
