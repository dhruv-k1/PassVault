import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pass/firebase_options.dart';
import 'package:pass/screens/generator_screen.dart';
import 'package:pass/screens/login_screen.dart';
import 'package:pass/screens/signup_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'provider/addpassword_provider.dart';
import 'package:pass/screens/add_password_screen.dart';
import 'package:provider/provider.dart';
import 'screens/vault_screen.dart';

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
    // ResponsiveSizer(
    //   builder:  (context, Orientation.portrait, ScreenType.mobile){
    //     Device.orientation == Orientation.portrait
    // ? Container(   // Widget for Portrait
    //     width: 100.w,
    //     height: 20.5.h,
    //  )
    // : Container(   // Widget for Landscape
    //     width: 100.w,
    //     height: 12.5.h,
    //  );
    //  Device.screenType == ScreenType.tablet
    // ? Container(   // Widget for Tablet
    //     width: 100.w,
    //     height: 20.5.h,
    //  )
    // : Container(   // Widget for Mobile
    //     width: 100.w,
    //     height: 12.5.h,
    //  );
    return FutureBuilder(
        future: _initialization,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            print('error bro');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                ListenableProvider<Password>(create: (context) => Password())
              ],
              child: MaterialApp(
                // theme: ThemeData(
                //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                //useMaterial3: true,
                //),
                home: ResponsiveSizer(
                    builder: (context, orientation, screenType) {
                  return LoginScreen();
                }),

                routes: {
                  VaultScreen.routeName: (ctx) => VaultScreen(),
                  AddPasswordScreen.routeName: (ctx) => AddPasswordScreen(),
                  LoginScreen.routeName: (ctx) => LoginScreen(),
                  SignUpScreen.routeName: (context) => SignUpScreen(),
                  GeneratorScreen.routeName: (context) => GeneratorScreen()
                },
              ),
            );
          }
          return CircularProgressIndicator();
        }));
  }
  // );
}
