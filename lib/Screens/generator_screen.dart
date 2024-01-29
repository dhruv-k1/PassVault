import 'package:flutter/material.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  static const routeName = '/generator';

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: size.height * 0.4,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black54,
              )),
            )
          ],
        ),
      ),
    );
  }
}
