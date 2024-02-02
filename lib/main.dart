import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pass/Bottom%20navigation%20bar/home_screen.dart';
import 'package:pass/Models/themes.dart';
import 'package:pass/firebase_options.dart';
import 'package:pass/Bottom%20navigation%20bar/generator_screen.dart';
import 'package:pass/screens/login_screen.dart';
import 'package:pass/screens/signup_screen.dart';
import 'package:pass/screens/update_password_screen.dart';
import 'provider/addpassword_provider.dart';
import 'package:pass/screens/add_password_screen.dart';
import 'package:provider/provider.dart';
import 'Bottom navigation bar/vault_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('error bro');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                ListenableProvider<Password>(create: (context) => Password())
              ],
              child: MaterialApp(
                theme: ThemeClass.lightTheme,
                darkTheme: ThemeClass.darkTheme,
                home: LoginScreen(),
                routes: {
                  HomeScreen.routeName: (context) => HomeScreen(),
                  VaultScreen.routeName: (ctx) => VaultScreen(),
                  AddPasswordScreen.routeName: (ctx) => AddPasswordScreen(),
                  LoginScreen.routeName: (ctx) => LoginScreen(),
                  SignUpScreen.routeName: (context) => SignUpScreen(),
                  GeneratorScreen.routeName: (context) => GeneratorScreen(),
                },
              ),
            );
          }
          return CircularProgressIndicator();
        }));
  }
  // );
}
