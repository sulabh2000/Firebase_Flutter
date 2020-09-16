import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyStream extends StatefulWidget {
  @override
  _MyStreamState createState() => _MyStreamState();
}

class _MyStreamState extends State<MyStream> {
  var fa = FirebaseAuth.instance;
  var fs = FirebaseFirestore.instance;
  String chatmsg;
  var msgtextcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var devicewidth = MediaQuery.of(context).size.width;
    var signinuser = fa.currentUser.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Chat Stream'),
        leading: Icon(Icons.chat_bubble),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                builder: (context, snapshot) {
                  //  print("new data comes");
                  var msg = snapshot.data.docs;
                  List<Widget> y = [];
                  for (var d in msg) {
                    var msgText = d.data()['text'];
                    var msgSender = d.data()['sender'];
                    var msgWidget = Text("$msgText send by $msgSender");
                    y.add(msgWidget);
                  }

                  return Container(
                    child: Column(children: y),
                  );
                },
                stream: fs.collection("chat").snapshots(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: devicewidth * 0.70,
                    child: TextField(
                      controller: msgtextcontroller,
                      onChanged: (value) {
                        chatmsg = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter msg',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      textAlign: TextAlign.center,
                      autocorrect: true,
                    ),
                  ),
                  SizedBox(
                    width: devicewidth * 0.050,
                  ),
                  Container(
                      width: devicewidth * 0.20,
                      child: FlatButton(
                        onPressed: () async {
                          msgtextcontroller.clear();
                          await fs.collection("chat").add({
                            "text": chatmsg,
                            "sender": signinuser,
                          });
                        },
                        child: Text('SEND'),
                        color: Colors.green,
                        textColor: Colors.white,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
