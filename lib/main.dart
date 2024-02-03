import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pass/Bottom%20navigation%20bar/home_screen.dart';
import 'package:pass/Models/themes.dart';
import 'package:pass/firebase_options.dart';
import 'package:pass/Bottom%20navigation%20bar/generator_screen.dart';
import 'package:pass/screens/login_screen.dart';
import 'package:pass/screens/signup_screen.dart';
import 'package:pass/screens/update_password_screen.dart';

import 'package:pass/screens/add_password_screen.dart';
import 'package:provider/provider.dart';
import 'Bottom navigation bar/vault_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  // ChangeNotifierProvider(
  //   create: (context) => SliderValue(),
  //   child: MyApp(),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ThemeData get lightTheme => ThemeData(
  //       primarySwatch: Colors.blue,
  //       // Add other properties for your light theme
  //     );
  //const MyApp({super.key});
  ThemeClass themeClass = ThemeClass();

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
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeClass.lightTheme,
              //darkTheme: ThemeClass.darkTheme,
              home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HomeScreen();
                    } else
                      return LoginScreen();
                  }),
              routes: {
                HomeScreen.routeName: (context) => HomeScreen(),
                VaultScreen.routeName: (ctx) => VaultScreen(),
                AddPasswordScreen.routeName: (ctx) => AddPasswordScreen(),
                LoginScreen.routeName: (ctx) => LoginScreen(),
                SignUpScreen.routeName: (context) => SignUpScreen(),
                GeneratorScreen.routeName: (context) => GeneratorScreen(),
              },
            );
          }
          return CircularProgressIndicator();
        }));
  }
  // );
}
