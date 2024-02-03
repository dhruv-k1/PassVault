import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pass/Models/encryption.dart';
import 'package:pass/screens/update_password_screen.dart';
import 'package:provider/provider.dart';

import '../Models/userkey.dart';
import 'package:firebase_core/firebase_core.dart';

import '../provider/addpassword_provider.dart';

class PasswordList extends StatefulWidget {
  @override
  PasswordListState createState() => PasswordListState();
}

class PasswordListState extends State<PasswordList> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> savedPasswords = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Saved passwords')
      .snapshots();

  final encryptionService = EncryptionService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: savedPasswords,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('ERROR!!!');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List realPass = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            realPass.add(a);
            a['id'] = document.id;
          }).toList();

          String realPassword(String pa) {
            final enPassword = Encrypted.fromBase64(pa);
            String dePassword = encryptionService.decryptPassword(enPassword);
            // String dePass = encryptionService.decryptPassword(pa);
            return dePassword;
          }

          Future<void> deletePassword(id) async {
            try {
              await firestore
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('Saved passwords')
                  .doc(id)
                  .delete()
                  .then((doc) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  width: size.width * 0.4,
                  behavior: SnackBarBehavior.floating,
                  //backgroundColor: Colors.red,
                  content: Text(
                    'Password removed!',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1), // Set the duration
                ));
              });
            } catch (e) {
              print("Error deleting document $e");
            }
          }

          if (realPass.length >= 1) {
            return Padding(
              padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
              child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return InkWell(
                      child: Container(
                          // width: size.width * 0.1,
                          child: Card(
                              elevation: 3,
                              child: ListTile(
                                leading: Container(
                                  child: Icon(Icons.lock_sharp),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black54,
                                      width: size.aspectRatio * 6,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  padding: EdgeInsets.all(5),
                                ),
                                title: Text(
                                  realPass[index]['Name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.028,
                                      color: const Color.fromARGB(
                                          255, 60, 60, 60)),
                                ),
                                subtitle: Text(realPass[index]['Email']!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.height * 0.02,
                                        color: Colors.grey)),
                                horizontalTitleGap: 0,
                                onTap: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      )),
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey.shade400,
                                                          width: size.height *
                                                              0.0016))),
                                              child: ListTile(
                                                title: Text(
                                                  'Show Password',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                trailing:
                                                    Icon(Icons.remove_red_eye),
                                                onTap: () {
                                                  // print(realPassword(
                                                  //     realPass[index]
                                                  //         ["Password"]));
                                                  Navigator.pop(context);

                                                  showDialog(
                                                    barrierDismissible: true,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SimpleDialog(
                                                          title: Text(
                                                            realPass[index]
                                                                ['Name'],
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.03,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800),
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          children: [
                                                            SimpleDialogOption(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context); // Dismiss the SimpleDialog
                                                              },
                                                              child: Text(
                                                                'Email: ' +
                                                                    realPass[
                                                                            index]
                                                                        [
                                                                        "Email"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.height *
                                                                            0.02,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                            SimpleDialogOption(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context); // Dismiss the SimpleDialog
                                                              },
                                                              child: Text(
                                                                'Username: ' +
                                                                    realPass[
                                                                            index]
                                                                        [
                                                                        "Username"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.height *
                                                                            0.02,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                            SimpleDialogOption(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context); // Dismiss the SimpleDialog
                                                              },
                                                              child: Text(
                                                                'Password: ' +
                                                                    realPass[
                                                                            index]
                                                                        [
                                                                        "Password"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        size.height *
                                                                            0.02,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ]);
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey.shade400,
                                                          width: size.height *
                                                              0.0016))),
                                              child: ListTile(
                                                title: Text('Edit'),
                                                trailing: Icon(Icons.edit),
                                                onTap: () {
                                                  Navigator.pop(context);

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdatePasswordScreen(
                                                                id: realPass[
                                                                        index]
                                                                    ['id'],
                                                              )));
                                                },
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey.shade400,
                                                          width: size.height *
                                                              0.0016))),
                                              child: ListTile(
                                                title: Text('Delete'),
                                                trailing: Icon(Icons.delete),
                                                onTap: () {
                                                  deletePassword(
                                                      realPass[index]['id']);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ))),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      splashColor: Theme.of(context).primaryColor,
                    );
                  }),
                  itemCount: realPass.length),
            );
          } else
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No passwords stored yet...',
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            );
        });
  }
}
