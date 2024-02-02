import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pass/user_auth/firebase_functions.dart';

class FirebaseAuthService {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  signupwithEmailandPassword(
      String email, String masterpassword, BuildContext context) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: masterpassword);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration Successful'),
      ));
    } catch (e) {
      print('Some error occured');
    }
    return null;
  }

  Future<User?> signinwithEmailandPassword(
      String email, String masterpassword) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: masterpassword);
      return credential.user;
    } catch (e) {
      print('Some error occured');
    }
    return null;
  }
}
