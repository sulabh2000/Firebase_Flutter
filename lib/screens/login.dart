import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String email;
  String password;
  bool spin = false;
  var authc = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.check_circle),
        title: Text('Login'),
        actions: <Widget>[
          Material(
            color: Colors.blue,
            elevation: 30,
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
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Center(
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
                        borderRadius: BorderRadius.circular(20)),
                  ),
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Material(
                  color: Colors.lightBlueAccent,
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialButton(
                    minWidth: 200,
                    height: 40,
                    onPressed: () async {
                      setState(() {
                        spin = true;
                      });
                      try {
                        var user = await authc.signInWithEmailAndPassword(
                            email: email, password: password);
                        print(user);
                        if (user.additionalUserInfo.isNewUser == false) {
                          Navigator.pushNamed(context, "cam");
                          setState(() {
                            spin = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Logged In",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } catch (e) {
                        print(e);
                        Fluttertoast.showToast(
                            msg: "Invalid Credentials",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
