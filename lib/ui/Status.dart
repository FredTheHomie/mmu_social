import 'package:flutter/material.dart';

class Status extends StatelessWidget {

  final status;

  Status({this.status});


  final dp = new ClipOval(
    child: new Container(
      color: Colors.white,
      height: 50.0,
      child: new Image(
          image: new AssetImage('assets/img/userPic.png')
      ),
    ),
  );

  final names = new Container(
    margin: const EdgeInsets.only(left: 60.0, right: 15.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
            'Ranj Salih',
          style: new TextStyle(
            fontSize: 12.0
          ),
        ),
        new Text(
          '@FredTheHomie',
          style: new TextStyle(
              fontSize: 13.0,
              color: Colors.blue
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: new Text(
            'This is my first status! I just wanted to say Hello to everyone! Dart is awesome but Flutter is the greatest. Combining Flutter and Firebase are what dream are made of.',
            style: new TextStyle(
              fontSize: 14.0
            ),
          ),
        ),
        new Row(
          children: <Widget>[
            new Container(
              child: new Icon(
                  Icons.thumb_up,
                color: Colors.grey,
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 5.0),
              child: new Text(
                  '4',
                style: new TextStyle(
                  fontSize: 15.0
                ),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 50.0),
              child: new Icon(
                Icons.message,
                color: Colors.grey,
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 60.0),
              child: new Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    ),
  );

  final dateWrote = new Container(
    alignment: FractionalOffset.topRight,
    child: new Container(
      child: new Text(
        '31-01-2018',
        style: new TextStyle(
          fontSize: 12.0
        ),
      ),
    ),
  );

  final statusContent = new Container(

  );

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    h(double num) {
      return (num / 100) * screenSize.height;
    }
    w(double num) {
      return (num / 100) * screenSize.width;
    }
    return new Card(
      elevation: 20.0,
      child: new Container(
        alignment: FractionalOffset.topLeft,
        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
        width: w(98.0),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: <Color>[
                const Color(0x99ef5350),
                const Color(0x00ef5350)
              ])
        ),
        child: new Stack(
          children: <Widget>[
            dp,
            names,
            dateWrote
          ],
        )
      ),
    );
  }
}