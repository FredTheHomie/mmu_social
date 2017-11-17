import 'package:flutter/material.dart';
import '../services/validation.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../data/user.dart';
import '../services/authentication.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key : key);

  @override
  MyAppState createState() => new MyAppState();
}


class MyAppState extends State<MyApp> {

  BuildContext context;

  //final googleSignIn = new GoogleSignIn();
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance;
  UserData userData = new UserData();
  UserAuth userAuth = new UserAuth();

  ScrollController scrollController = new ScrollController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  Validation validation = new Validation();

  void snackBar(String val) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(val)));
  }

  checkIf(DataSnapshot snapshot) {
    if(snapshot != null)
      print('yes');
    else
      print('no');
  }


  Future<Map<String, dynamic>> getObject(String category, String id) async {
    DataSnapshot snap = await ref.reference().child('users/$id').once();
    return snap.value;
  }

  _handleSubmitted() async {
    final FormState form = formKey.currentState;
    FirebaseAuth auth = FirebaseAuth.instance;

    if (!form.validate()) {
      autovalidate = true;
    } else {
      form.save();
      auth.signInWithEmailAndPassword(
          email: userData.email,
          password: userData.password).then((s) async {
        FirebaseUser user = await auth.currentUser();
        if(user != null) {
         //DataSnapshot s;
         //print(ref.reference().child('users/${user.uid}/username').equalTo('').toString());
          /*if(await getObject(user.toString(), user.uid) != null)
            print('exists');
          else
            print('does not'); */
          (await getObject(user.toString(), user.uid) != null)
              == true ? Navigator.pushNamed(context, '/LoggedIn')
              : Navigator.pushNamed(context, '/CreateInfo');
        }


      }).catchError((err) {
        snackBar(err.toString());
      });
      /*userAuth.logIn(userData).then((s) {
        //FirebaseUser user = await auth.currentUser();
        if (auth.currentUser() != null)
          print('worked');
      }).catchError((onError) {
        snackBar(onError.details);
      }); */
    }
  }
    /*Future<Null> _logWithGoogle() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null)
      user = await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
    }
    if (await auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
      await googleSignIn.currentUser.authentication;
      await auth.signInWithGoogle(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
      );
    }
  }

  Future<Null> logOut() async {
    googleSignIn.signOut();
  }

     Future<Null> _handle() async {
      await _logWithGoogle();
      GoogleSignInAccount user = googleSignIn.currentUser;
      print(user);
      /*ref.reference().child('users/' + user.id).set(<String,String>{
        'uid': user.id
      });*/
     */

    @override
    Widget build(BuildContext context) {
    this.context = context;
      final Size screenSize = MediaQuery
          .of(context)
          .size;
    h(double num) {
      return (num / 100) * screenSize.height;
    }
    w(double num) {
      return (num / 100) * screenSize.width;
    }
      Validation validation = new Validation();
      return new Scaffold(
        key: _scaffoldKey,
        body: new SingleChildScrollView(
          controller: scrollController,
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Center(
                  child: new Container(
                    margin: new EdgeInsets.only(top: (screenSize.height - (screenSize.height - 10.0))),
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
                  margin: new EdgeInsets.only(
                    top: (screenSize.height < 570) ? h(20.0) : h(28.0)),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Material(
                            child: new Column(
                                children: <Widget>[
                                  new GestureDetector(
                                    child: new Image(
                                      image: new AssetImage(
                                          "assets/img/googleLogin.png"),
                                      width: w(70.0),
                                    ),
                                    onTap: () {}

                                  ),
                                  new Container(
                                      margin: new EdgeInsets.only(
                                          top: 5.0),
                                      child: new Text("Or")
                                  ),
                                  new Form(
                                    autovalidate: autovalidate,
                                    key: formKey,
                                    child: new Column(
                                      children: <Widget>[
                                        new TextFormField(
                                          decoration: new InputDecoration(
                                              hintText: 'Email'
                                          ),
                                          validator: validation.validateEmail,
                                          onSaved: (String email) {
                                            userData.email = email;
                                          },
                                        ),
                                        new TextFormField(
                                          decoration: new InputDecoration(
                                              hintText: 'Password'
                                          ),
                                          validator: validation
                                              .validatePassword,
                                          obscureText: true,
                                          onSaved: (String pass) {
                                            userData.password = pass;
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  /* new GestureDetector(
                                      onTap: () {
                                        // logOut();
                                      },
                                      child: new Container(
                                          margin: new EdgeInsets.only(
                                              bottom: 10.0),
                                          alignment: new FractionalOffset(
                                              1.0, 0.5),
                                          child: new Text("Forgot password?")
                                      )
                                  ), */
                                  new RaisedButton(
                                    onPressed: _handleSubmitted,
                                    color: Colors.blue,
                                    child: new Text(
                                      "Login",
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  new Container(
                                    margin: new EdgeInsets.only(top: 15.0),
                                    child: new GestureDetector(
                                      child: new Text(
                                          "New member? Sign up here!"),
                                      onTap: () {  Navigator.pushNamed(context, '/CreateAccount'); }
                                    ),

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