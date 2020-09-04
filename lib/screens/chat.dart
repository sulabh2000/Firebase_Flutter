import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var authc = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('WELCOME USER'),
              RaisedButton(
                onPressed: () async {
                  await authc.signOut();
                },
                child: Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
