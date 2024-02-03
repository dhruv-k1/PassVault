import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pass/Models/themes.dart';
import 'package:pass/screens/add_password_screen.dart';
import 'package:pass/Widgets/passwords_list.dart';
import 'package:pass/Bottom%20navigation%20bar/generator_screen.dart';

class VaultScreen extends StatefulWidget {
  static const routeName = '/vaultscreen';

  @override
  State<VaultScreen> createState() => VaultScreenState();
}

class VaultScreenState extends State<VaultScreen> {
  final Future<FirebaseApp> _initialization1 = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization1,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            print('errorss bro');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 221, 2, 2),
                title: Text(
                  'Vault',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              body: PasswordList(),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AddPasswordScreen.routeName);
                  },
                  child: Icon(Icons.add)),
            );
          }
          return CircularProgressIndicator();
        }));
  }
}
