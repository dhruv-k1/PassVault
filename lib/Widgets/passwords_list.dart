import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pass/Models/encryption.dart';
import 'package:pass/Widgets/password_options.dart';

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
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      child: InkWell(
                        // width: size.width * 0.1,
                        child: Card(
                            color: Color.fromRGBO(255, 206, 206, 1),
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
                                    color:
                                        const Color.fromARGB(255, 60, 60, 60)),
                              ),
                              subtitle: Text(realPass[index]['Email']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.height * 0.02,
                                      color: const Color.fromARGB(
                                          255, 90, 90, 90))),
                              horizontalTitleGap: 0,
                              onTap: () {
                                Get.bottomSheet(
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: BottomSheetDetails(
                                        name: realPass[index]['Name'],
                                        username: realPass[index]['Username'],
                                        email: realPass[index]['Email'],
                                        password: realPass[index]['Password'],
                                        id: realPass[index]['id'],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(size.width * 0.05),
                                      topRight:
                                          Radius.circular(size.width * 0.05),
                                    )),
                                    backgroundColor: Colors.white);
                              },
                            )),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        splashColor: Theme.of(context).primaryColor,
                      ),
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
