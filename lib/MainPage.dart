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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                  Tab(
                    text: 'Update',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ReadPage(),
            WritePage(),
            UpdatePage(),
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
    return Container(
      child: Center(child: Text("Write")),
    );
  }

  UpdatePage() {
    return Container(
      child: Center(child: Text("Update")),
    );
  }

  _fetchListItems() async {
    // var response =
    //     await Dio().get('http://127.0.0.1:8080/api/queryAllbyOwner/');

    // var response = await Dio()
    //     .get('https://c9addy.github.io/test-json/queryAllbyOwner.json');
    // localhost:8080/api/queryAllbyOwner/y
    final response = await http.get(
      Uri.parse('http://65.1.153.111/api/queryAllbyOwner/'),
      //     headers: {
      //   'Access-Control-Allow-Origin': '*',
      //   'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
      //   'Access-Control-Allow-Headers': '*',
      // }
    );
    // final response = await http.get(
    //     Uri.parse('https://c9addy.github.io/test-json/queryAllbyOwner.json'));

    // Uri.https('c9addy.github.io', 'test-json/queryAllbyOwner.json'),
    // headers: {"Accept": "application/json"});
    // print(response.data['response'].toString());
    print('Hiiii');

    var jsonData = jsonDecode(response.body);
    var values = jsonData['response'];
    // var values = response.data['response'];
    return values;
  }
}
