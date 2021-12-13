import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
  RecordsPage({Key? key, this.recds, this.pat_id}) : super(key: key);
  final recds;
  final pat_id;

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  TextEditingController _textFieldController = TextEditingController();

  _displayDialogGrant(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Grant Access to ID'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              // keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "ID"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Grant'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _displayDialogRevoke(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Revoke Access from ID'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              // keyboardType: TextInputType.,
              decoration: InputDecoration(hintText: "ID"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Revoke'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(widget.pat_id, style: TextStyle(fontSize: 15.0)),
        ),
        body: new ListView.builder(
            itemCount: widget.recds.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text(
                          "Data: " + widget.recds[index]['data'].toString()),
                      subtitle: Text(
                          "Type: " + widget.recds[index]['type'].toString()),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          _displayDialogGrant(context);
                        },
                        child: Card(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                            child: Center(
                                child: Text(
                              "Grant",
                              style: TextStyle(fontSize: 15.0),
                            )),
                          ),
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          _displayDialogRevoke(context);
                        },
                        child: Card(
                          color: Colors.red.shade200,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                            child: Center(
                                child: Text(
                              "Revoke",
                              style: TextStyle(fontSize: 15.0),
                            )),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              );
            }));
  }
}
