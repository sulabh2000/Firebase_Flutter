import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegis extends StatefulWidget {
  @override
  _MyRegisState createState() => _MyRegisState();
}

class _MyRegisState extends State<MyRegis> {
  var auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RaisedButton(
                onPressed: () async {
                  var y = await auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  print(y);
                  
                },
                child: Text('Sign Up'),
              )
            ],
          ),
        ));
  }
}
