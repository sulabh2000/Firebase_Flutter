import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetest_app/screens/chat.dart';
import 'package:firetest_app/screens/home.dart';
import 'package:firetest_app/screens/login.dart';
import 'package:firetest_app/screens/regis.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => MyHome(),
      "log": (context) => MyLogin(),
      "reg": (context) => MyRegis(),
      "chat": (context) => MyChat(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

//code for Firestore connection
/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fsconnect = FirebaseFirestore.instance;
    String name;
    String gender;
    var uid;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Database'),
          leading: Icon(Icons.date_range),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  gender = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  uid = value;
                },
              ),
              RaisedButton(
                onPressed: () {
                  fsconnect.collection("Students").add({
                    "Name": name,
                    "Gender": gender,
                    "Universityid": uid,
                  });
                },
                child: Text('Send'),
              ),
              RaisedButton(
                onPressed: () async {
                  var d = await fsconnect.collection("Students").get();
                  for (var i in d.docs) print(i.data());
                },
                child: Text('Retrieve'),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
*/
