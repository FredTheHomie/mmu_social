import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';
import '../ui/Status.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FirebaseAnimatedListState> _listKey = new GlobalKey<FirebaseAnimatedListState>();

  PageController _pageController;

  int _page = 0;

  String _title = 'Chat';

  Query _query;

  _query1() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();

    if (this._query == null) {
      new Text('Please Wait');
      setState(() {
        this._query = FirebaseDatabase.instance.reference()
            .child('users/${user.uid}').orderByChild('email').equalTo('bob@bob.com');
      });
    }
  }

  oo() {
    if(_query == null)
      return new Text('Please wait');
    else {
      return new Container(
        color: Colors.white,
        child: new FirebaseAnimatedList(
            query: _query,
            padding: new EdgeInsets.all(8.0),
            reverse: false,
            itemBuilder: (_, DataSnapshot snapshot,
                Animation<double> animation, int x) {
              return new ListTile(
                subtitle: new Text(
                    snapshot.value.toString()
                ),
              );
            }),
      );
    }
  }

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _query1();
      return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text(_title),
        ),
        body: new PageView(
          children: <Widget>[
            /*new Flexible(
              child: null,
            ), */
              /*new Container(
                color: Colors.white,
                child: new CustomScrollView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    new SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      sliver: new SliverList(
                          delegate: new SliverChildBuilderDelegate(
                              (context, index) => new Status(),
                            childCount: 5
                          )
                      ),
                    )
                  ],
                ),
              ), */
            /*new Container(
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new Text('asdasdsad'),
                  new Status(),
                ],
              ),
            ), */
            oo(),
            /* new Container(
              color: Colors.white,
              child: new SingleChildScrollView(
                controller: scrollController,
                child: new Column(
                  children: <Widget>[
                    new Text('asdasdasd')
                  ],
                ),
              ),
            ), */
            new Container(color: Colors.blue),
            new Container(color: Colors.grey)
          ],
          controller: _pageController,
          onPageChanged: onPageChanged,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new Container(
                height: 120.0,
                child: new DrawerHeader(
                  padding: new EdgeInsets.all(0.0),
                  decoration: new BoxDecoration(
                    color: new Color(0xFFECEFF1),
                  ),
                  child: new Center(
                    child: new Icon(
                      Icons.home,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              new ListTile(
                leading: new Icon(Icons.supervisor_account),
                title: new Text('Profile'),
                onTap: () {
                  setState(() {
                    this._page = 2;
                    Navigator.pop(context);
                    navigationTapped(_page);

                  });
                },
              ),
              new Divider(),
              new ListTile(
                leading: new Icon(Icons.chat),
                title: new Text('Feed'),
                onTap: () {
                  setState(() {
                    this._page = 0;
                    Navigator.pop(context);
                    navigationTapped(_page);

                  });
                },
              ),
              new ListTile(
                leading: new Icon(Icons.web),
                title: new Text('Chat'),
                onTap: () {
                  setState(() {
                    this._page = 1;
                    Navigator.pop(context);
                    navigationTapped(_page);

                  });
                },
              ),
              new ListTile(
                leading: new Icon(Icons.search),
                title: new Text('Search friends'),
                onTap: () {
                  setState(() {
                    this._page = 2;
                    Navigator.pop(context);
                    navigationTapped(_page);

                  });
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.web),
                title: new Text('Feed')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.chat),
                title: new Text('Chat')
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('Search'),
            )
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
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
    switch (page) {
      case 0:
        _title = 'Feed';
        break;
      case 1:
        _title = 'Chat';
        break;
      case 2:
        _title = 'Search';
        break;
    }
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
