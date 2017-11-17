import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/user.dart';
import '../services/validation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';

class Gender {
  const Gender(this.gender);
  final String gender;
}

class CreateInfo extends StatefulWidget {

  @override
  CreateInfoState createState() => new CreateInfoState();
}

class CreateInfoState extends State<CreateInfo> {

  BuildContext context;

  Gender selectedGender;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  List<Gender> genders = <Gender>[const Gender('Male'), const Gender('Female')];
  UserData userData = new UserData();
  String day = "0";
  String month = "0";
  String year = "0";
  bool autovalidate = false;
  Validation validation = new Validation();

  File _imageFile;

  getImage() async {
      var _fileName = await ImagePicker.pickImage();
      setState(() {
        _imageFile = _fileName;
      });
  }

  img() {
    if(_imageFile == null)
      return new FileImage(_imageFile);
    else
      return new AssetImage('assets/img/userPic.png');
  }

  saveGender() {
    final FormState form = formKey.currentState;
    form.save();
    userData.gender = selectedGender.gender.toString();
    userData.dob = '$day/$month/$year';

    print(userData.username);
  }

   _handleCreation() async {
    final FormState form = formKey.currentState;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseDatabase ref = FirebaseDatabase.instance;
    if(!form.validate()) {
      autovalidate = true;
    }
    if(form.validate()) {
      form.save();
      FirebaseUser currentUser = await auth.currentUser();
      ref.reference().child('users/' + currentUser.uid).set(<String, String> {
        'username': userData.username,
        'firstname': userData.firstName,
        'lastname': userData.lastName,
        'gender': userData.gender,
        'dob': userData.dob,
        'email': currentUser.email
      }).then((s) {
        StorageReference sref = FirebaseStorage.instance.ref().child('users/' + currentUser.uid);
        sref.put(_imageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context){
    this.context = context;
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new Stack(
              alignment: FractionalOffset.bottomRight,
              children: <Widget>[
                new Container(
                    margin: new EdgeInsets.only(top: 80.0),
                    child: new CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: _imageFile == null ? new AssetImage('assets/img/userPic.png') : new FileImage(_imageFile), //_imageFile == null ? new AssetImage('assets/img/userPic.png') : new FileImage(_imageFile),
                      radius: 60.0,
                    )
                ),
                new FloatingActionButton(
                  onPressed: getImage,
                  child: new Icon(Icons.add),
                )
              ],
            ),
            new Container(
              margin: const EdgeInsets.only(top: 90.0, left: 25.0, right: 25.0),
              child: new Material(
                child: new Form(
                  key: formKey,
                  autovalidate: autovalidate,
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'Username'
                        ),
                        validator: validation.validateName,
                        onSaved: (String uName) {
                          userData.username = uName;
                        },
                      ),
                        new Container(
                          margin: const EdgeInsets.only(top: 35.0),
                          child: new Row(
                            children: <Widget>[
                              new Flexible(
                                child: new TextFormField(
                                  decoration: new InputDecoration(
                                      hintText: 'First name'
                                  ),
                                  validator: validation.validateName,
                                  onSaved: (String name) {
                                    userData.firstName = name;
                                  },
                                ),
                              ),
                              new Expanded(
                                child: new TextFormField(
                                  decoration: new InputDecoration(
                                      hintText: 'Second name'
                                  ),
                                  validator: validation.validateName,
                                  onSaved: (String name) {
                                    userData.lastName = name;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      new Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        width: 300.0,
                        child: new DropdownButton<Gender>(
                          value: selectedGender,
                          onChanged: (Gender select) {
                            setState(() {
                              selectedGender = select;
                              saveGender();
                            });
                          },
                          items: genders.map((Gender gender) {
                            return new DropdownMenuItem<Gender>(
                              value: gender,
                              child: new Text(
                                gender.gender,
                                style: new TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: new Text('Select Gender')
                        )
                      ),
                      new Container(
                        margin: new EdgeInsets.only(top: 15.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                                  child: new TextFormField(
                                      decoration: new InputDecoration(
                                        hintText: 'Day'
                                      ),
                                    validator: validation.validateDay,
                                    onSaved: (String day1) {
                                        day = day1;
                                    },
                                  ),
                            ),
                            new Expanded(
                                child: new Text(' / ')
                            ),
                            new Expanded(
                                  child: new TextFormField(
                                    decoration: new InputDecoration(
                                        hintText: 'Month'
                                  ),
                                    validator: validation.validatMonth,
                                    onSaved: (String month1) {
                                      month = month1;
                                    },
                                )
                            ),
                            new Expanded(
                                child: new Text(' / ')
                            ),
                            new Expanded(
                                  child: new TextFormField(
                                    decoration: new InputDecoration(
                                        hintText: 'Year'
                                  ),
                                    validator: validation.validatYear,
                                    onSaved: (String year1) {
                                      year = year1;
                                    },
                                )
                            ),
                          ],
                        )
                      ),
                      new Container(
                        margin: new EdgeInsets.only(top: 5.0),
                        child: new RaisedButton(
                          onPressed: _handleCreation,
                          color: Colors.blue,
                          child: new Text(
                            "Login",
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}