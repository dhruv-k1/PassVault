import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pass/provider/addpassword_provider.dart';
import 'package:pass/screens/vault_screen.dart';
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
  final _form = GlobalKey<FormState>();
  var _newKey = UserKey(
      id: DateTime.now().toString(),
      title: '',
      password: '',
      username: null,
      email: '');

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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

      context.read<Password>().addNewPassword(
          ntitle: _newKey.title,
          nusername: _newKey.username,
          npassword: _newKey.password,
          nid: _newKey.id,
          nemail: _newKey.email);
      Navigator.of(context).pop(VaultScreen.routeName);
    }

    /*CollectionReference CurrentPasswords =
        FirebaseFirestore.instance.collection('User 1');

    Future<void> addPass() {
      return CurrentPasswords.add({
        'Name': _newKey.title,
        'Email': _newKey.email,
        'Username': _newKey.username,
        'Password': _newKey.password
      })
          .then((value) => print('password added!'))
          .catchError((error) => print('FAiled'));
    }*/
    final FirebaseFirestore db = FirebaseFirestore.instance;

    Future<void> addPass() async {
      return db.collection('User 1').add({
        'Name': _newKey.title,
        'Email': _newKey.email,
        'Username': _newKey.username,
        'Password': _newKey.password
      }).then((value) => print("Added Data with ID: "));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Password'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  _saveForm();
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: ListView(children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_usernameFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    } else
                      return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      _newKey = UserKey(
                          id: _newKey.id,
                          username: _newKey.username,
                          password: _newKey.password,
                          title: nameController.text,
                          email: _newKey.email);
                    } else
                      return;
                  }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  focusNode: _usernameFocusNode,
                  decoration: InputDecoration(
                      hintText: 'Username',
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  controller: usernameController,
                  onSaved: (value) {
                    if (value != null) {
                      _newKey = UserKey(
                          id: _newKey.id,
                          username: usernameController.text,
                          password: _newKey.password,
                          title: _newKey.title,
                          email: _newKey.email);
                    } else
                      return;
                  }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  onSaved: (value) {
                    if (value != null) {
                      _newKey = UserKey(
                          id: _newKey.id,
                          username: _newKey.username,
                          password: value,
                          title: _newKey.title,
                          email: _newKey.email);
                    } else
                      return;
                  }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value != null && !value.contains('@')) {
                    return 'Please enter valid email';
                  } else
                    return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _newKey = UserKey(
                        id: _newKey.id,
                        username: _newKey.username,
                        password: _newKey.password,
                        title: _newKey.title,
                        email: value);
                  } else
                    return;
                },
                onFieldSubmitted: (_) {
                  _saveForm();
                },
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            _saveForm();
                            addPass;
                          }
                        },
                        child: Text('Save'))
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
