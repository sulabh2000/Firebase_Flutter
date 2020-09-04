import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
        leading: Icon(Icons.ac_unit),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "reg");
                },
                child: Text('Register'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "log");
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
