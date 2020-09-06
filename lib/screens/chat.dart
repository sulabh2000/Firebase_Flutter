import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var authc = FirebaseAuth.instance;
  var fsconnect = FirebaseFirestore.instance;
  var command;
  myweb(cmd) async {
    var url = "http://192.168.43.33/cgi-bin/stop.py?x=${cmd}";
    var response = await http.get(url);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.chat),
        title: Center(child: Text('Chat')),
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
          width: 400,
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
                      var x = await myweb(command);
                      fsconnect.collection("Students").add({
                        "Output": x,
                      });
                    },
                    child: Text("Run Command"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
