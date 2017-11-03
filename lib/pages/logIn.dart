import 'package:flutter/material.dart';
import 'package:mmu_social/services/validation.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key : key);

  @override
  MyAppState createState() => new MyAppState();
}


class MyAppState extends State<MyApp> {
  BuildContext context;
  ScrollController scrollController = new ScrollController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool autovalidate = false;
  Validation validation = new Validation();

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    Validation validation = new Validation();
    return new Scaffold(
      body: new SingleChildScrollView(
        controller: scrollController,
        child: new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              new Center(
                child: new Container(
                  padding: new EdgeInsets.only(top: 40.0),
                  child: new Image(
                    image: new AssetImage("assets/img/Mmu-logo.png"),
                    width: (screenSize.width < 500)
                        ? 220.0
                        : (screenSize.width / 4) + 12.0,
                    height: screenSize.height / 4 + 20,
                  ),
                ),
              ),
              new Container(
                  height: screenSize.height / 1.4,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Material(
                          child: new Column(
                              children: <Widget>[
                                new Image(
                                  image: new AssetImage("assets/img/googleLogin.png"),
                                  width: 280.0,
                                ),
                                new Container(
                                    padding: new EdgeInsets.only(top: 20.0, bottom: 10.0),
                                    child: new Text("Or")
                                ),
                                new Form(
                                  autovalidate: autovalidate,
                                  key: formKey,
                                  child: new Column(
                                    children: <Widget>[
                                      new TextFormField(
                                        decoration: new InputDecoration(
                                            hintText: 'Email or Username'
                                        ),
                                        validator: validation.validateEmail,
                                      ),
                                      new TextFormField(
                                        decoration: new InputDecoration(
                                            hintText: 'Password'
                                        ),
                                        validator: validation.validatePassword,
                                        obscureText: true,
                                      )
                                    ],
                                  ),
                                ),
                                new GestureDetector(
                                    onTap: () {
                                      setState(() { Navigator.of(context).pushNamed('/LoggedIn'); });
                                    },
                                    child: new Container(
                                        padding: new EdgeInsets.only(bottom: 15.0),
                                        alignment: new FractionalOffset(1.0, 0.5),
                                        child: new Text("Forgot password?")
                                    )
                                ),
                                new RaisedButton(
                                  onPressed: _handleSubmitted,
                                  color: Colors.blue,
                                  child: new Text(
                                    "Login",
                                    style: new TextStyle(color: Colors.white),
                                  ),
                                ),
                                new Container(
                                  padding: new EdgeInsets.only(top: 15.0),
                                  child: new Text("New member? Sign up here!"),
                                )
                              ]
                          )
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
