import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  final Stream<QuerySnapshot> savedPasswords =
      FirebaseFirestore.instance.collection('User 1').snapshots();

  @override
  Widget build(BuildContext context) {
    //List<UserKey> passwords = context.watch<Password>().fake;

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

          return Padding(
            padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
            child: ListView.builder(
                itemBuilder: ((context, index) {
                  return InkWell(
                    child: Card(
                        elevation: 3,
                        child: ListTile(
                          leading: Container(
                            child: Icon(Icons.lock_sharp),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                                width: 3,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: EdgeInsets.all(5),
                          ),
                          title: Text(
                            realPass[index]['Name']!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: const Color.fromARGB(255, 60, 60, 60)),
                          ),
                          subtitle: Text(realPass[index]['Email']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.grey)),
                          horizontalTitleGap: 0,
                        )),
                    onTap: () {
                      print(realPass[index]);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    splashColor: Theme.of(context).primaryColor,
                  );
                }),
                itemCount: realPass.length),
          );
        });
  }
}




//Text( passwords[index].username, style: TextStyle( fontWeight: FontWeight.w500, fontSize: 17, color: Colors.grey))