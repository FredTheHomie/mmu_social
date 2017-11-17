import 'package:flutter/material.dart';
import 'package:mmu_social/services/validation.dart';

class ForgotPass extends StatefulWidget {

  @override
  ForgotPassState createState() => new ForgotPassState();
}

class ForgotPassState extends State<ForgotPass> {

  @override
  Widget build(BuildContext context){
    Validation validation = new Validation();
    return new Scaffold(
      body: new Container(
      padding: new EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new Material(
            child: new Column(
              children: <Widget>[
                new Form(
                  child: new Column(
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () { Navigator.pop(context); },
                        child: new Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 10.0),
                          child: new Image(
                            image: new AssetImage('assets/img/back.png'),
                            width: 50.0,
                          ),
                        )
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 50.0),
                         child: new Text(
                           'Change password',
                           style: new TextStyle(fontSize: 25.0),
                         )
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 100.0, left: 25.0, right: 25.0),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Your MMU Social email'
                          ),
                          validator: validation.validateEmail,
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 25.0),
                          child: new RaisedButton(
                            onPressed: () {},
                            color: Colors.blue,
                            child: new Text(
                                'Submit'
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      )
    );
  }
}