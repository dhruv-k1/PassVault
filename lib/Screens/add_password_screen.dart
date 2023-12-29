import 'package:flutter/material.dart';
import 'package:pass/Provider/addpassword_provider.dart';
import 'package:pass/Screens/vault_screen.dart';
import 'package:provider/provider.dart';
import '../Models/userkey.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key});
  static const routeName = '/addpassword';

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _form= GlobalKey<FormState>();
  var _newKey= UserKey(id: DateTime.now().toString(), title: '',password:'',username:'',email: '');

  void dispose(){
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 
  void _saveForm() {
   
    _form.currentState?.save();
  
    print(_newKey.id);
    print(_newKey.title);
    print(_newKey.username);
    print(_newKey.password);
    print(_newKey.email);
    context.read<Password>().addNewPassword(ntitle: _newKey.title, nusername: _newKey.username, npassword: _newKey.password, nid: _newKey.id, nemail: _newKey.email);
    Navigator.of(context).pop(VaultScreen.routeName);
  }
  
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Password'),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 20,),
                  border: OutlineInputBorder()
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_usernameFocusNode);
                },
                onSaved:(value ){
                if (value != null){
                  _newKey = UserKey(id: _newKey.id, username: _newKey.username, password: _newKey.password, title: value) ;
                }
                else return; 
               }
              ),
              SizedBox(height: 10,),
              TextFormField(
                focusNode: _usernameFocusNode,
                decoration: InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  labelStyle: TextStyle(fontSize: 20,),
                  border: OutlineInputBorder()
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaved:(value ){
                if (value != null){
                  _newKey = UserKey(id: _newKey.id, username: value, password: _newKey.password, title: _newKey.title) ;
                }
                else return; 
               }
              ),
              SizedBox(height: 10,),
              TextFormField(
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 20,),
                  border: OutlineInputBorder()
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                onSaved:(value ){
                if (value != null){
                  _newKey = UserKey(id: _newKey.id, username: _newKey.username, password: value, title: _newKey.title) ;
                }
                else return; 
               }
              ),
              SizedBox(height: 10,),
              TextFormField(
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 20,),
                  border: OutlineInputBorder()
                ),
                onSaved:(value ){
                if (value != null){
                  _newKey = UserKey(id: _newKey.id, username: _newKey.username, password: _newKey.password, title: _newKey.title, email: value) ;
                }
                else return; 
               },
                onFieldSubmitted: (_){
                  
                  _saveForm();
                },
              ),
              ]
              )
              ),
      ),
    );
  }
}