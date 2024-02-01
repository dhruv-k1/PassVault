import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pass/Bottom%20navigation%20bar/home_screen.dart';
import 'package:pass/Bottom%20navigation%20bar/vault_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _masterpFocusNode = FocusNode();
  final _confirmmasterpFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool invisibleText = true;
  bool invisibleText2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
              },
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red.shade50, Colors.red.shade100])),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 20, 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Create Account',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            // filled: true,
                            prefixIconColor: Colors.black,
                            // fillColor: Colors.red[200],
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            labelText: 'Email Address',
                            prefixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.mail)),
                            //border: OutlineInputBorder()
                          ),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_masterpFocusNode);
                          },
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        TextFormField(
                          focusNode: _masterpFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: invisibleText,
                          decoration: InputDecoration(

                              // filled: true,
                              prefixIconColor: Colors.black,
                              // fillColor: Colors.red[200],
                              contentPadding: EdgeInsets.symmetric(vertical: 1),
                              labelText: 'Master Password',
                              prefixIcon: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.key)),
                              // border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      invisibleText = !invisibleText;
                                    });
                                  },
                                  icon: Icon(invisibleText
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_confirmmasterpFocusNode);
                          },
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        TextFormField(
                          focusNode: _confirmmasterpFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: invisibleText2,
                          decoration: InputDecoration(

                              // filled: true,
                              prefixIconColor: Colors.black,
                              // fillColor: Colors.red[200],
                              contentPadding: EdgeInsets.symmetric(vertical: 1),
                              labelText: 'Confirm Master Password',
                              prefixIcon: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.key)),
                              // border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      invisibleText2 = !invisibleText2;
                                    });
                                  },
                                  icon: Icon(invisibleText2
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: Text('Continue'))
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}
