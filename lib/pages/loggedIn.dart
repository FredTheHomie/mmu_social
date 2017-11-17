import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


class LoggedIn extends StatefulWidget {
  const LoggedIn({Key key}) : super(key : key);

  @override
  LoggedInState createState() => new LoggedInState();
}

class LoggedInState extends State<LoggedIn> {

  BuildContext context;
  final GlobalKey<EditableTextState> textState = new GlobalKey<EditableTextState>();
  Text text1 = new Text('asdasdsadasdaa');

  Future<String> _userText() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    return user.displayName.toString();
  }


  signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signOut;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
      return new Container(
        height: 100.0,
        color: Colors.blue,
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Text(
               'asdsadasdasd'
              ),
            ),
            new Material(
              child: new RaisedButton(
                  onPressed: null
              ),
            ),
            new Material(
              child: new RaisedButton(
                onPressed: signOut,
              ),
            )
          ],
        ),
      );
  }
}