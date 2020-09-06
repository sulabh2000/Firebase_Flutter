import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyOutput extends StatefulWidget {
  @override
  _MyOutputState createState() => _MyOutputState();
}

class _MyOutputState extends State<MyOutput> {
  var fsconnect = FirebaseFirestore.instance;
  var x;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Output'),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
                color: Colors.lightBlueAccent,
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  minWidth: 100,
                  height: 40,
                  onPressed: () async {
                    try {
                      var d = await fsconnect.collection("Students").get();
                      for (var i in d.docs) print(i.data());
                      Fluttertoast.showToast(
                          msg: "Showing Database",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } catch (e) {}
                  },
                  child: Text("Retrieve"),
                )),
          ],
        ),
      ),
    );
  }
}
