import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pass/screens/update_password_screen.dart';

class BottomSheetDetails extends StatelessWidget {
  //const BottomSheetDetails({super.key});
  String name;
  String email;
  String username;
  String password;
  String id;

  BottomSheetDetails(
      {this.name = '',
      this.email = '',
      this.username = '',
      this.password = '',
      this.id = ''});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.shade400,
                      width: size.height * 0.0016))),
          child: ListTile(
            title: Text(
              'Show Password',
            ),
            trailing: Icon(Icons.remove_red_eye),
            onTap: () {
              // print(realPassword(
              //     realPass[index]
              //         ["Password"]));
              Navigator.pop(context);
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                      title: Text(
                        'Name: ' + name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.height * 0.03,
                            color: Colors.grey.shade800),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context); // Dismiss the SimpleDialog
                          },
                          child: Text(
                            'Email: ' + email,
                            style: TextStyle(
                                fontSize: size.height * 0.02,
                                color: Colors.grey),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context); // Dismiss the SimpleDialog
                          },
                          child: Text(
                            'Username: ' + username,
                            style: TextStyle(
                                fontSize: size.height * 0.02,
                                color: Colors.grey),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context); // Dismiss the SimpleDialog
                          },
                          child: Text(
                            'Password: ' + password,
                            style: TextStyle(
                                fontSize: size.height * 0.02,
                                color: Colors.grey),
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
                      color: Colors.grey.shade400,
                      width: size.height * 0.0016))),
          child: ListTile(
            title: Text('Edit'),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePasswordScreen(
                            id: id,
                          )));
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.shade400,
                      width: size.height * 0.0016))),
          child: ListTile(
            title: Text('Delete'),
            trailing: Icon(Icons.delete),
            onTap: () {
              deletePassword(id);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
