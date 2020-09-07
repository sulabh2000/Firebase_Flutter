import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var authc = FirebaseAuth.instance;
  var fsconnect = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application"),
        leading: Icon(Icons.account_circle),
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
    );
  }
}
