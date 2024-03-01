import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   //width: size.width * 0.5,
                //   behavior: SnackBarBehavior.floating,
                //   backgroundColor: Colors.red,
                //   content: Text(
                //     'Successfully signed out',
                //     textAlign: TextAlign.center,
                //   ),
                //   duration: Duration(seconds: 2),
                // ));
                Get.snackbar(
                  'Logged Out!',
                  'Signed out sucessfully',
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  backgroundColor: Colors.grey.shade800,
                  titleText: Text('Logged Out!',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                  messageText: Text('Signed out sucessfully',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center),
                  colorText: Colors.white,
                  maxWidth: size.width * 0.5,
                );
              },
              child: Text('Sign Out')),
        ));
  }
}
