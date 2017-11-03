import 'package:flutter/material.dart';
import 'pages/loggedIn.dart';
import 'pages/logIn.dart';

class Routes {

  var routes = <String, WidgetBuilder>{
    "/LoggedIn": (BuildContext context) => new LoggedIn()
  };

  Routes() {
    runApp(
      new MaterialApp(
        title: 'MMU Social App',
        home: new MyApp(),
        routes: routes,
      )
    );
  }
}