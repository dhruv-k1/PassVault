import 'package:flutter/material.dart';
import 'package:pass/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red.shade50, Colors.red.shade100])),
        child: SingleChildScrollView(
          child: Container(
            height: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.03),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                  ),
                  Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextField(
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
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        prefixIconColor: Colors.black,
                        fillColor: Colors.red[200],
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        hintText: 'Master Password',
                        prefixIcon:
                            IconButton(onPressed: () {}, icon: Icon(Icons.key)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  //InkWell(

                  SizedBox(
                    width: size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {},
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Container(
                        width: size.width * 0.43,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.fingerprint_sharp,
                                    size: 28,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).cardColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  )),
                              Text(
                                'Use biometrics..',
                                style: TextStyle(fontSize: 18),
                              )
                            ]),
                      )),
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
      ),
    );
  }
}
