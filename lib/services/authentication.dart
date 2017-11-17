import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/user.dart';

class UserAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> createUser(UserData userdata) async {
    await firebaseAuth
    .createUserWithEmailAndPassword(
        email: userdata.email,
        password: userdata.password);
    FirebaseUser user = await firebaseAuth.currentUser();
    return user;
  }

  Future<FirebaseUser> logIn(UserData userdata) async {
    await firebaseAuth
        .signInWithEmailAndPassword(
        email: userdata.email,
        password: userdata.password);
    FirebaseUser user = await firebaseAuth.currentUser();
    return user;
  }
}