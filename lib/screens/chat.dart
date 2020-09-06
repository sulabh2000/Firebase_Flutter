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
        leading: Icon(Icons.chat),
        title: Center(child: Text('Chat')),
        actions: <Widget>[
          Material(
            color: Colors.green,
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: MaterialButton(
              minWidth: 50,
              height: 5,
              onPressed: () async {
                await authc.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "log", (route) => false);
              },
              child: Text("Sign Out"),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
