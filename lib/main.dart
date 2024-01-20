import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pass/firebase_options.dart';
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
                home: VaultScreen(),
                routes: {
                  VaultScreen.routeName: (ctx) => VaultScreen(),
                  AddPasswordScreen.routeName: (ctx) => AddPasswordScreen(),
                },
              ),
            );
          }
          return CircularProgressIndicator();
        }));
  }
}
