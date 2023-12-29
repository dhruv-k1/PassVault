import '../Models/userkey.dart';
import 'package:provider/provider.dart';
import '../dummy_passwords.dart';
import 'package:flutter/material.dart';

class Password extends ChangeNotifier {
 /* final String nid ;
  final String ntitle = '';
  final String npassword ='';
  final String? nemail ='';
  final String nusername ='';
 // final UserKey np ;*/
 // Password({ required this.nid, }) 

  List<UserKey> fake = [
    UserKey(id: 'ukn', username: 'rahul', password: 'password', title: 'title'),
    UserKey(id: 'ukn1', username: 'rahul1', password: 'password', title: 'title'),
  ];
 

 void addNewPassword ({ required String ntitle , required String nusername , required String npassword ,required String nid, String? nemail }){
   final newPassword = UserKey(id: nid, username: nusername, password: npassword, title: ntitle , email: nemail);
   
  fake.add(newPassword);
    notifyListeners();
    } 
}