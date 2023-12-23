import 'package:flutter/material.dart';
import 'package:pass/dummy_passwords.dart';


class VaultScreen extends StatefulWidget {
  

  @override
  State <VaultScreen> createState() =>  VaultScreenState();
}

class  VaultScreenState extends State <VaultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vault'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body:
        Column(
          children: userkeys.map((uk) {
            return Card(
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
                      Text(uk.title, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 21, color: const Color.fromARGB(255, 60, 60, 60)),),
                      Text(uk.username, style: TextStyle( fontWeight: FontWeight.w500, fontSize: 17, color: Colors.grey))
                    ],
                  )
                ],
              ),
            );
          }
          ).toList() 
              ),
          
        
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
         BottomNavigationBarItem(icon: Icon(Icons.lock),label: 'Vault'),
         BottomNavigationBarItem(icon: Icon(Icons.generating_tokens),label: 'Generator'), 
         BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'), 
         ] ,
    )
    );
  }
}