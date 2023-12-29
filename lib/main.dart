import 'package:flutter/material.dart';
import './Provider/addpassword_provider.dart';
import 'package:pass/Screens/add_password_screen.dart';
import 'package:provider/provider.dart';
import 'Screens/vault_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<Password>(create: (context) => Password() )
      ],
      child: MaterialApp(
               // theme: ThemeData(
           //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
           //useMaterial3: true,
         //),
        home: VaultScreen(),
        routes: {
           VaultScreen.routeName: (ctx) => VaultScreen(),
           AddPasswordScreen.routeName:(ctx) => AddPasswordScreen(),
        },
      ),
    );
  }
}

