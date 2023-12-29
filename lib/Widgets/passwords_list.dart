import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/userkey.dart';
import '../dummy_passwords.dart';
import '../Provider/addpassword_provider.dart' ;

class PasswordList extends StatefulWidget { 
  @override
  PasswordListState createState() =>  PasswordListState();
}

class  PasswordListState extends State<PasswordList> {
  
 // List<UserKey> passlist = context.watch<Password>().userkeys;
  //get passlist;
  //final List<UserKey> passwords=Provider.of<Password>(context);
  
  @override
  Widget build(BuildContext context) {

    List<UserKey> passwords = context.watch<Password>().fake;
    
    return Padding( 
      padding: EdgeInsets.fromLTRB(5,10,5,10 ),
      child: ListView.builder(itemBuilder: ((context, index) {
        return InkWell(
              child: Card(
                elevation: 3,
                child: Row(
                  children: [
                    Container(
                      child: Icon(Icons.lock_sharp),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.black54,
                          width: 3,
                        ) ,
                        borderRadius: BorderRadius.all( Radius.circular(20)),
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(passwords[index].title, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 21, color: const Color.fromARGB(255, 60, 60, 60)),),
                        Text(passwords[index].username, style: TextStyle( fontWeight: FontWeight.w500, fontSize: 17, color: Colors.grey))
                      ],
                    )
                  ],
                ),
              ),
              onTap: (){},
              borderRadius: BorderRadius.all(Radius.circular(20)),
              splashColor: Theme.of(context).primaryColor,
            );
      }),
      itemCount: passwords.length ),
      );
  }
}