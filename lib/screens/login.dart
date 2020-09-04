import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var authc = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
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
                  var x = await authc.signInWithEmailAndPassword(
                      email: email, password: password);
                  print(x);
                  if (x != null) {
                    Navigator.pushNamed(context, "chat");
                  }
                },
                child: Text('Sign In'),
              )
            ],
          ),
        ));
  }
}
