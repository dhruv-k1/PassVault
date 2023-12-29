import 'package:flutter/material.dart';
import 'package:pass/Screens/add_password_screen.dart';
import 'package:pass/Widgets/passwords_list.dart';
import 'package:pass/dummy_passwords.dart';

class VaultScreen extends StatefulWidget {
   static const routeName = '/vaultscreen';

  
  @override
  State <VaultScreen> createState() =>  VaultScreenState();
}

class VaultScreenState extends State <VaultScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vault'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body: PasswordList(), 
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(AddPasswordScreen.routeName);
        },
        child:Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
         BottomNavigationBarItem(icon: Icon(Icons.lock),label: 'Vault'),
         BottomNavigationBarItem(icon: Icon(Icons.generating_tokens),label: 'Generator'), 
         BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'), 
         ],
    )
    );
  }
}    