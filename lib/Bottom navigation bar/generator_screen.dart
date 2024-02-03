import 'package:flutter/material.dart';
import 'package:pass/Models/randomkey.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  static const routeName = '/generator';

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  int passwordlength = 8;
  bool isLowercase = true;
  bool isUppercase = true;
  bool isNumbers = true;
  bool isSpecialCh = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String rpass = generateRandomPassword(
      includeLowercase: isLowercase,
      includeUppercase: isUppercase,
      includeNumbers: isNumbers,
      includeSpecialChars: isSpecialCh,
      length: passwordlength,
    );

    void checkSwitches() {
      if (!(isLowercase || isUppercase || isNumbers || isSpecialCh)) {
        setState(() {
          isLowercase = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(
            'Password must contain atleast one of these types',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3), // Set the duration
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 2, 2),
        title: Text(
          'Password Generator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.01,
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: size.height * 0.27,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 6, 147, 48),
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 2, 55, 32),
                          width: size.height * 0.007)),
                ),
                child: Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      rpass,
                      style: TextStyle(
                          fontSize: size.height * 0.04, color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: rpass));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          width: size.width * 0.4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Copied to clipboard!',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 2), // Set the duration
                        ));
                      },
                      icon: Icon(Icons.copy_outlined),
                      color: Colors.white,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                ]),
              ),
              Container(
                padding: EdgeInsets.all(size.height * 0.020),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password length: " +
                          passwordlength.toString() +
                          ' characters',
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                      ),
                    ),
                    Slider(
                      inactiveColor: Colors.red.shade200,
                      min: 4,
                      max: 20,
                      divisions: 17,
                      //label: passwordlength.toInt().toString(),
                      value: passwordlength.toDouble(),
                      onChanged: (double newvalue) {
                        setState(() {
                          passwordlength = newvalue.round();
                        });
                        passwordlength = newvalue.round();
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Password must include',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.025,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ListTile(
                      title: Text(
                        'Lowecase (abc)',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.025,
                        ),
                      ),
                      trailing: Switch(
                          value: isLowercase,
                          onChanged: (value) {
                            setState(() {
                              isLowercase = value;
                              checkSwitches();
                            });
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.017,
                    ),
                    ListTile(
                      title: Text(
                        'Uppercase(ABC)',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.025,
                        ),
                      ),
                      trailing: Switch(
                          value: isUppercase,
                          onChanged: (value) {
                            setState(() {
                              isUppercase = value;
                              checkSwitches();
                            });
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.017,
                    ),
                    ListTile(
                      title: Text(
                        'Numbers (123)',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.025,
                        ),
                      ),
                      trailing: Switch(
                          value: isNumbers,
                          onChanged: (value) {
                            setState(() {
                              isNumbers = value;
                              checkSwitches();
                            });
                          }),
                    ),
                    SizedBox(
                      height: size.height * 0.017,
                    ),
                    ListTile(
                      title: Text(
                        'Special Characters (!#\$)',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.025,
                        ),
                      ),
                      trailing: Switch(
                          value: isSpecialCh,
                          onChanged: (value) {
                            setState(() {
                              isSpecialCh = value;
                              checkSwitches();
                            });
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
