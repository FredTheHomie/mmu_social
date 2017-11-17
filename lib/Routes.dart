import 'package:flutter/material.dart';
import 'pages/loggedIn.dart';
import 'pages/logIn.dart';
import 'pages/createAccount.dart';
import 'pages/forgot.dart';
import 'pages/createInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class Routes {

  var routes = <String, WidgetBuilder>{
    "/Home": (BuildContext context) => new MyApp(),
    "/LoggedIn": (BuildContext context) => new LoggedIn(),
    "/CreateAccount": (BuildContext context) => new CreateAccount(),
    "/ForgotPass": (BuildContext context) => new ForgotPass(),
    "/CreateInfo": (BuildContext context) => new CreateInfo()
  };

  final ref = FirebaseDatabase.instance;

  Future<Map<String, dynamic>> getObject(String category, String id) async {
    DataSnapshot snap = await ref.reference().child('users/$id').once();
    return snap.value;
  }




  plis() async {
    Widget mm;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    getObject(user.toString(), user.uid).then((s) {
      if(s == null)
        mm = new CreateInfo();
      else
        mm = new LoggedIn();
    });
    /*if(getObject(user.toString(), user.uid) != null) {
      print('asdadasdasdasd');
      mm = new LoggedIn();
    }
    else {
      print('dsdsdsdsdsdsdsdsds');
      mm = new CreateInfo();
    } */

  }
  Routes1() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    runApp(
      new MaterialApp(
        title: 'MMU Social App',
        home: ((user == null) != true)
            ? new LoggedIn()
            : new MyApp(),
        routes: routes,
      )
    );
  }
}