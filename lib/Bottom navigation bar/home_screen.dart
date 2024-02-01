import 'package:flutter/material.dart';
import 'package:pass/Bottom%20navigation%20bar/generator_screen.dart';
import 'package:pass/Bottom%20navigation%20bar/vault_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myCurrentIndex = 0;
  List pages = [VaultScreen(), GeneratorScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[myCurrentIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.5),
                blurRadius: 25,
                offset: Offset(0, 20))
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              selectedItemColor: Colors.red.shade400,
              unselectedItemColor: Colors.grey,
              currentIndex: myCurrentIndex,
              onTap: (index) {
                if (index < pages.length) {
                  setState(() {
                    myCurrentIndex = index;
                  });
                } else
                  myCurrentIndex = 0;
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Vault'),
                BottomNavigationBarItem(
                  // ,
                  icon: Icon(Icons.model_training),

                  label: 'Generator',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ));
  }
}
