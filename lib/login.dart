import 'package:ehr/MainPage.dart';
import 'package:ehr/admin_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idcontroller = TextEditingController();
  String selectedValue = "Patient";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> roles = [
      DropdownMenuItem(child: Text("Admin"), value: "Admin"),
      DropdownMenuItem(child: Text("Patient"), value: "Patient"),
      DropdownMenuItem(child: Text("Doctor"), value: "Doctor"),
      DropdownMenuItem(child: Text("Pharmacy"), value: "Pharmacy"),
      DropdownMenuItem(child: Text("Diagnostic Lab"), value: "Diagnostic Lab"),
      DropdownMenuItem(child: Text("Insurance"), value: "Insurance"),
    ];
    return roles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LOGIN"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Role", style: TextStyle(fontSize: 20.0)),
                SizedBox(width: 10),
                DropdownButton(
                    style: TextStyle(fontSize: 20.0),
                    value: selectedValue,
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    }),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: idcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ID',
                  hintText: 'Enter Your ID',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: FlatButton(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  if (selectedValue == "Admin") {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminPage(
                              my_id: idcontroller.text,
                            )));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainPage(
                              my_id: idcontroller.text,
                            )));
                  }
                },
              ),
            ),
          ],
        ));
  }
}
