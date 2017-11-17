import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';


class LoggedIn extends StatefulWidget {

  @override
  LoggedInState createState() => new LoggedInState();
}

class LoggedInState extends State<LoggedIn> {

  /*_signOut() async {
    FirebaseAuth auth = await FirebaseAuth.instance.signOut();
    auth;
    if(auth == null)
      print('out');
    else
      print('in');
  } */
  PageController _pageController;

  int _page = 1;

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        body: new PageView(
          children: <Widget>[
            new Container(color: Colors.red),
            new Container(color: Colors.blue),
            new Container(color: Colors.grey)
          ],
          controller: _pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.chat),
                title: new Text('Chat')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.web),
                title: new Text('Feed')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('Search')
            )
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        )
      );
  }
  void navigationTapped(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
