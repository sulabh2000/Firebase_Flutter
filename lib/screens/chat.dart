//For running Linux commands

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

var x = "Nothing to Show";

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var authc = FirebaseAuth.instance;
  var fsconnect = FirebaseFirestore.instance;
  var command;
  myweb(cmd) async {
    var url = "http://192.168.43.33/cgi-bin/command.py?x=${cmd}";
    var response = await http.get(url);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.chat),
        title: Center(child: Text('Hello World!')),
        actions: <Widget>[
          Material(
            color: Colors.blue,
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: MaterialButton(
              minWidth: 50,
              height: 5,
              onPressed: () async {
                await authc.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "log", (route) => false);
                Fluttertoast.showToast(
                    msg: "Signed Out",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Text("Sign Out"),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  command = value;
                },
                decoration: InputDecoration(
                    hintText: "Type Command",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                  color: Colors.lightBlueAccent,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialButton(
                    minWidth: 100,
                    height: 40,
                    onPressed: () async {
                      try {
                        var y = await myweb(command);
                        x = y;
                        fsconnect.collection("Command").add({
                          "Output": y,
                        });
                        Fluttertoast.showToast(
                            msg: "Command run successfully, Saving in Database",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } catch (e) {}
                    },
                    child: Text("Run Command"),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          try {
            Fluttertoast.showToast(
                msg: "Showing Database",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushNamed(context, "out");
          } catch (e) {}
        },
        label: Text("Check Database"),
        icon: Icon(Icons.bubble_chart),
        backgroundColor: Colors.lightBlueAccent[300],
      ),
    );
  }
}

class MyOutput extends StatefulWidget {
  @override
  _MyOutputState createState() => _MyOutputState();
}

class _MyOutputState extends State<MyOutput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Output")),
      ),
      body: Container(
        color: Colors.grey,
        child: Center(child: Text("$x")),
      ),
    );
  }
}
