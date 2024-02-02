import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pass/Bottom%20navigation%20bar/home_screen.dart';
import 'package:pass/Bottom%20navigation%20bar/vault_screen.dart';
import 'package:pass/screens/login_screen.dart';
import 'package:pass/user_auth/firebase_auth_services.dart';

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

  //final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String storeMaster = '';
    String storeEmail = '';

    void _saveForm() {
      _form.currentState?.save();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(HomeScreen.routeName);
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
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        TextFormField(
                          controller: _emailController,
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
                          onSaved: (value) {
                            setState(() {
                              storeEmail = value!;
                            });
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_masterpFocusNode);
                          },
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        TextFormField(
                          // controller: _passwordController,
                          focusNode: _masterpFocusNode,
                          //keyboardType: TextInputType.emailAddress,
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
                          onSaved: (value) {
                            setState(() {
                              storeMaster = value!;
                            });
                          },
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
                          //keyboardType: TextInputType.emailAddress,
                          obscureText: invisibleText2,
                          validator: (value) {
                            if (value != storeMaster) {
                              return 'Master password doesn\'t match';
                            } else
                              return null;
                          },
                          onFieldSubmitted: (_) => _saveForm(),
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
                                onPressed: () async {
                                  print('object');
                                  final data = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: storeEmail,
                                    password: storeMaster,
                                  );
                                  print(data);
                                  _saveForm();
                                  // if (_form.currentState!.validate()) {
                                  //   FirebaseAuthService
                                  //       .signupwithEmailandPassword(
                                  //           storeEmail, storeMaster, context);
                                  //   signUp(
                                  //       email: storeEmail,
                                  //       masterpassword: storeMaster);
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(SnackBar(
                                  //     width: size.width * 0.5,
                                  //     behavior: SnackBarBehavior.floating,
                                  //     //backgroundColor: Colors.red,
                                  //     content: Text(
                                  //       'Successfully signed up!',
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //     duration: Duration(seconds: 2),
                                  //     // Set the duration
                                  //   ));
                                  // }
                                },
                                child: Text('Continue'))
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
