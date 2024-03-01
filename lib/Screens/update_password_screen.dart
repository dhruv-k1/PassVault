import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pass/Bottom%20navigation%20bar/vault_screen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String id;
  const UpdatePasswordScreen({super.key, required this.id});
  // final routeName = '/updatepassword';

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _form = GlobalKey<FormState>();

  CollectionReference savedInfo = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Saved passwords');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<void> updateInfo(id, name, username, email, password) {
      return savedInfo.doc(id).update({
        'Name': name,
        'Username': username,
        'Email': email,
        'Password': password,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          width: size.width * 0.5,
          behavior: SnackBarBehavior.floating,
          //backgroundColor: Colors.red,
          content: Text(
            'Password successfully updated!',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2), // Set the duration
        ));
        Navigator.of(context).pop(VaultScreen.routeName);
      }).catchError((error) => print('Failed to update password: $error'));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 221, 2, 2),
          title: Text('Update Password',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Saved passwords')
              .doc(widget.id)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something went wrong');
            }

            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            // if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data();
            var savedName = data!['Name'];
            var savedEmail = data['Email'];
            var savedUsername = data['Username'];
            var savedPassword = data['Password'];

            return Padding(
              padding: EdgeInsets.all(size.width * 0.004),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          size.width * 0.05,
                          size.height * 0.04,
                          size.width * 0.05,
                          size.height * 0.01),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: savedName,
                        onChanged: (value) {
                          savedName = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: size.height * 0.018)),
                        //textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Please enter name";
                          } else
                            return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.01),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: savedUsername,
                        onChanged: (value) {
                          savedUsername = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Username',
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: size.height * 0.018)),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Please enter name";
                          } else
                            return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.01),
                      child: TextFormField(
                        initialValue: savedPassword,
                        onChanged: (value) {
                          savedPassword = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: size.height * 0.018)),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Please enter password";
                          } else
                            return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.01),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: savedEmail,
                        onChanged: (value) {
                          savedEmail = value;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: size.height * 0.02,
                            ),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: size.height * 0.018)),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "*Please enter email address";
                          } else if (!value.contains('@')) {
                            return "*Please enter valid email";
                          } else
                            return null;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  updateInfo(widget.id, savedName,
                                      savedUsername, savedEmail, savedPassword);
                                }
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(fontSize: size.height * 0.02),
                              ))
                        ],
                      ),
                    )
                  ]))),
            );
            // }

            // return SizedBox.shrink();
          },
        ));
  }
}
