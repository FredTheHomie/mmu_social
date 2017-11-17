import 'package:flutter/material.dart';
import '../services/validation.dart';
import '../services/authentication.dart';
import '../data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key : key);

  @override
  CreateAccountState createState() => new CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {

  BuildContext context;
  ScrollController scrollController = new ScrollController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  Validation validation = new Validation();
  UserData userData = new UserData();
  UserAuth userAuth = new UserAuth();

  void _handleSubmitted() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true;
    } else {
      form.save();
      userAuth.createUser(userData).then((onValue) async {
        FirebaseUser user = await auth.currentUser();
        if(user != null) {
           await auth.signInWithEmailAndPassword(
              email: userData.email,
              password: userData.password);
           Navigator.pushNamed(context, '/CreateInfo');
          //snackBar(onValue.toString());
        }
          //Navigator.pop(context);
      }).catchError((onError) {
        snackBar(onError);
      });
    }

  }

  void snackBar(String val) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(val)));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
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
                                            hintText: 'Email'
                                        ),
                                        onSaved: (String email) {
                                          userData.email = email;
                                        },
                                      ),
                                      new TextFormField(
                                        decoration: new InputDecoration(
                                            hintText: 'Password'
                                        ),
                                        validator: validation.validatePassword,
                                        obscureText: true,
                                        onSaved: (String password) {
                                          userData.password = password;
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                new RaisedButton(
                                  onPressed: _handleSubmitted,
                                  color: Colors.blue,
                                  child: new Text(
                                    "Join!",
                                    style: new TextStyle(color: Colors.white),
                                  ),
                                ),
                                new GestureDetector(
                                  onTap: () { Navigator.pop(context); },
                                  child: new Container(
                                    padding: new EdgeInsets.only(top: 15.0),
                                    child: new Text("Already a member? Log in here!"),
                                  ),
                                ),
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


class RoundedButton extends StatelessWidget {
  String buttonName;
  final VoidCallback onTap;
  double height;
  double width;
  double bottomMargin;
  double borderWidth;
  Color buttonColor;

  TextStyle textStyle = const TextStyle(
      color: const Color(0XFFFFFFFF),
      fontSize: 16.0,
      fontWeight: FontWeight.bold);

  //passing props in react style
  RoundedButton(
      {this.buttonName,
        this.onTap,
        this.bottomMargin,
        this.borderWidth,
        this.width,
        this.buttonColor});

  @override
  Widget build(BuildContext context) {
    if (borderWidth != 0.0)
      return (new InkWell(
        onTap: onTap,
        child: new Container(
          width: width,
          height: height,
          margin: new EdgeInsets.only(bottom: bottomMargin),
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
              color: buttonColor,
              borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
              border: new Border.all(
                  color: const Color.fromRGBO(221, 221, 221, 1.0),
                  width: borderWidth)),
          child: new Text(buttonName, style: textStyle),
        ),
      ));
    else
      return (new InkWell(
        onTap: onTap,
        child: new Container(
          width: width,
          height: height,
          margin: new EdgeInsets.only(bottom: bottomMargin),
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
            color: buttonColor,
            borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
          ),
          child: new Text(buttonName, style: textStyle),
        ),
      ));
  }
}