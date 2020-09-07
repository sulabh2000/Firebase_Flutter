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
  var name, uid, email, mno, college, course, year;
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
      body: Center(
        child: Container(
          width: 400,
          color: Colors.red[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  uid = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Unique Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  college = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter College Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  course = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Enrolled Course",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  year = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Current College Year",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  mno = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Mobile Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.blue,
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  minWidth: 200,
                  height: 5,
                  onPressed: () async {
                    var user = await fsconnect.collection("Applications").add({
                      "name": name,
                      "email": email,
                      "unique id": uid,
                      "college name": college,
                      "course": course,
                      "year": year,
                      "mobile number": mno,
                    });
                    Fluttertoast.showToast(
                        msg: "SUbmitted Successfully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
