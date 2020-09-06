import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegis extends StatefulWidget {
  @override
  _MyRegisState createState() => _MyRegisState();
}

class _MyRegisState extends State<MyRegis> {
  String email;
  String password;
  var authc = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.verified_user),
        title: Text('Registration'),
        actions: <Widget>[
          Material(
            color: Colors.green,
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: MaterialButton(
              minWidth: 50,
              height: 5,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              },
              child: Text("Go to Home"),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: MaterialButton(
                  minWidth: 200,
                  height: 40,
                  onPressed: () async {
                    try {
                      var user = await authc.createUserWithEmailAndPassword(
                          email: email, password: password);
                      print(user);
                      if (user.additionalUserInfo.isNewUser == true) {
                        Navigator.pushNamed(context, "chat");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
