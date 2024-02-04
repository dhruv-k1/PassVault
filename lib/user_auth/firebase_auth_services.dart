import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pass/Bottom%20navigation%20bar/home_screen.dart';

import '../screens/login_screen.dart';

class FirebaseAuthService {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CircularProgressIndicator();

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'Password': password,
        'Email': email,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //width: size.width * 0.5,
        behavior: SnackBarBehavior.floating,
        //backgroundColor: Colors.red,
        content: Text(
          'Successfully signed up!',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ));
      Navigator.of(context).pop(LoginScreen.routeName);
      print('Signup successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Email already exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print('Error during signup: $e');
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    Size size = MediaQuery.sizeOf(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Login successful');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   //width: size.width * 0.5,
      //   behavior: SnackBarBehavior.floating,
      //   //backgroundColor: Colors.red,
      //   content: Text(
      //     'Successfully logged in!',
      //     textAlign: TextAlign.center,
      //   ),
      //   duration: Duration(seconds: 2),
      // ));
      Get.snackbar('Logged In', 'Successfully signed in!',
          snackPosition: SnackPosition.BOTTOM,
          messageText: Text('Successfully signed in!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: Colors.grey.shade800,
          colorText: Colors.white,
          maxWidth: size.width * 0.5,
          margin: EdgeInsets.all(size.height * 0.02));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text('Email doesn\'t exist')));
        Get.snackbar('Error!', 'Email doesn\'t exist',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            maxWidth: size.width * 0.5,
            margin: EdgeInsets.all(size.height * 0.02),
            duration: const Duration(seconds: 2));
      } else if (e.code == 'wrong-password') {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Incorrect password entered ')));
        Get.snackbar('Error!', 'Incorrect password entered',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            maxWidth: size.width * 0.5,
            margin: EdgeInsets.all(size.height * 0.02));
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   //width: size.width * 0.5,
      //   behavior: SnackBarBehavior.floating,
      //   backgroundColor: Colors.red,
      //   content: Text(
      //     e.toString(),
      //     textAlign: TextAlign.center,
      //   ),
      //   duration: Duration(seconds: 2),
      // ));
      Get.snackbar('Error!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          maxWidth: size.width * 0.5,
          margin: EdgeInsets.all(size.height * 0.02));
    }
  }
}
