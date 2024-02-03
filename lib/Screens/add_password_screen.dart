import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Bottom navigation bar/vault_screen.dart';
import 'package:provider/provider.dart';
import '../Models/encryption.dart';

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

  bool invisibleText = true;

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

  final encryptionService = EncryptionService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _saveForm() {
      _form.currentState?.save();
    }

    final FirebaseFirestore db = FirebaseFirestore.instance;

    void addPass() {
      print('add pass');
      db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Saved passwords')
          .doc(_newKey.id)
          .set({
        "Name": _newKey.title,
        'Email': _newKey.email,
        'Username': _newKey.username,
        'Password': _newKey.password
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: size.width * 0.5,
        behavior: SnackBarBehavior.floating,
        //backgroundColor: Colors.red,
        content: Text(
          'Password successfully stored!',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2), // Set the duration
      ));
      Navigator.of(context).pop(VaultScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 2, 2),
        title: Text(
          'Add Password',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Form(
            key: _form,
            child: ListView(children: <Widget>[
              TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.05))),
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
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.05))),
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
                  obscureText: invisibleText,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.05)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              invisibleText = !invisibleText;
                            });
                          },
                          icon: Icon(invisibleText
                              ? Icons.visibility
                              : Icons.visibility_off))),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  onSaved: (value) {
                    if (value != null) {
                      String encryptedValue =
                          encryptionService.encryptPassword(value).base64;

                      _newKey = UserKey(
                          id: _newKey.id,
                          username: _newKey.username,
                          password: encryptedValue,
                          title: _newKey.title,
                          email: _newKey.email);
                    } else
                      return;
                  }),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: FirebaseAuth.instance.currentUser!.email,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(size.width * 0.05))),
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
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            _saveForm();
                            addPass();
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
