import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass/screens/signup_screen.dart';
import 'package:pass/user_auth/firebase_auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool invisibleText = true;
  final _form = GlobalKey<FormState>();
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 255, 235, 238),
                Colors.red.shade100
              ])),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(size.height * 0.03),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.35,
                      ),
                      Text(
                        'PassVault',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      TextFormField(
                        controller: _emailController,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            filled: true,
                            prefixIconColor: Colors.black87,
                            fillColor: Colors.red[200],
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            hintText: 'Email',
                            prefixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.person)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none)),
                        validator: (value) {
                          if (value != null && !value.contains('@')) {
                            return 'Please enter valid email';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: invisibleText,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            filled: true,
                            prefixIconColor: Colors.black,
                            fillColor: Colors.red[200],
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            hintText: 'Master Password',
                            prefixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.key)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    invisibleText = !invisibleText;
                                  });
                                },
                                icon: Icon(invisibleText
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter masterpassword';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      //InkWell(

                      SizedBox(
                        width: size.width * 0.3,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              _auth.signIn(_emailController.text,
                                  _passwordController.text, context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: size.height * 0.05,
                            alignment: Alignment.center,
                            child: Text('Log In',
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      // TextButton(
                      //     onPressed: () {},
                      //     child: Container(
                      //       width: size.width * 0.5,
                      //       child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //                 margin: EdgeInsets.all(size.width * 0.001),
                      //                 child: Icon(
                      //                   Icons.fingerprint_sharp,
                      //                   size: size.width * 0.08,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   border: Border.all(
                      //                       color: Theme.of(context).cardColor),
                      //                   borderRadius: BorderRadius.all(
                      //                       Radius.circular(size.width * 0.05)),
                      //                 )),
                      //             Text(
                      //               'Use biometrics..',
                      //               style: TextStyle(fontSize: size.width * 0.05),
                      //             )
                      //           ]),
                      //     )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not using PassVault yet?'),
                          TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(SignUpScreen.routeName),
                              child: Text('Sign Up!'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
