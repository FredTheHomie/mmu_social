import 'package:flutter/material.dart';
import 'pages/loggedIn.dart';
import 'pages/logIn.dart';
import 'pages/createAccount.dart';
import 'pages/forgot.dart';
import 'pages/createInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Routes {

  var routes = <String, WidgetBuilder>{
    "/Home": (BuildContext context) => new MyApp(),
    "/LoggedIn": (BuildContext context) => new LoggedIn(),
    "/CreateAccount": (BuildContext context) => new CreateAccount(),
    "/ForgotPass": (BuildContext context) => new ForgotPass(),
    "/CreateInfo": (BuildContext context) => new CreateInfo()
  };

  ifRoute() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if(auth.currentUser() == null)
      return runApp(
          new MaterialApp(
            title: 'MMU Social App',
            home: new MyApp(),
            routes: routes,
          )
      );
    else
      return runApp(
          new MaterialApp(
            title: 'MMU Social App',
            home: new LoggedIn(),
            routes: routes,
          )
      );
  }

  bool _checkRoute() {
    FirebaseAuth auth = FirebaseAuth.instance;
    return !(auth.currentUser() == null);
  }

  Routes() {
    runApp(
      new MaterialApp(
        title: 'MMU Social App',
        home: _checkRoute == true ? new LoggedIn() : new MyApp(),
        routes: routes,
      )
    );
    //ifRoute();
  }
}