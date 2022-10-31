import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splashscreen/splashscreen.dart';

import 'logic/binary.dart';
import 'logic/decimal.dart';
import 'logic/funcions.dart';
import 'logic/hexadecimal.dart';
import 'logic/octal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Splash(),
    );
  }
}
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Converter()
            )
        )
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/logo.png'),
      color: Color(0xFF6C60FF)
    );
  }
}

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  var octal = TextEditingController();
  var decimal = TextEditingController();
  var hexadecimal = TextEditingController();
  var binary = TextEditingController();
  var len = 100;

  void lengthChange(int leng) {
    setState(() {
      len = leng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Base Converter"),
        actions: [Container(
          margin: EdgeInsets.only(right: 8),
          child: IconButton(onPressed: () {
            binary.text = "";
            octal.text = "";
            decimal.text = "";
            hexadecimal.text = "";
          },
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashRadius: 20,
            icon: Icon(Icons.refresh),

          ),
        )
        ],
      ),
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: binary,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                    filled: true,
                    labelText: "Binary",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.blueAccent))),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-1]*\.?[0-1]{0,64}')),
                ],
                onChanged: (value) {
                  if (searchFunction(value, '.')) {
                    if (value[value.indexOf('.')] != value[value.length - 1]) {
                      if (binaryFraction(value, 8).length >= 16) {
                        octal.text = binaryToOtherSystem(
                                value.substring(0, value.indexOf('.')), 8) +
                            '.' +
                            binaryFraction(value, 8).substring(0, 16);
                      } else {
                        octal.text = binaryToOtherSystem(
                                value.substring(0, value.indexOf('.')), 8) +
                            '.' +
                            binaryFraction(value, 8);
                      }
                      decimal.text = binaryFraction(value, 10);
                      if (binaryFraction(value, 16).length >= 16) {
                        hexadecimal.text = binaryToOtherSystem(
                                value.substring(0, value.indexOf('.')), 16) +
                            '.' +
                            binaryFraction(value, 16).substring(0, 16);
                      } else {
                        hexadecimal.text = binaryToOtherSystem(
                                value.substring(0, value.indexOf('.')), 16) +
                            '.' +
                            binaryFraction(value, 16);
                      }
                    }
                  } else if (value == "") {
                    octal.text = "";
                    decimal.text = "";
                    hexadecimal.text = "";
                  } else {
                    octal.text = binaryToOtherSystem(value, 8);
                    decimal.text = binaryToOtherSystem(value, 10);
                    hexadecimal.text = binaryToOtherSystem(value, 16);
                  }
                },
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: octal,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-7]*\.?[0-7]{0,24}')),
                ],
                style: TextStyle(fontSize: 25),
                onChanged: (value) {
                  if (searchFunction(value, '.')) {
                    if (value[value.indexOf('.')] != value[value.length - 1]) {
                      binary.text = octalFraction(value, 2);
                      decimal.text = octalFraction(value, 10);
                      hexadecimal.text = octalToOtherSystem(
                              value.substring(0, value.indexOf('.')), 16) +
                          '.' +
                          octalFraction(value, 16);
                    }
                  } else if (value == "") {
                    binary.text = "";
                    decimal.text = "";
                    hexadecimal.text = "";
                  } else {
                    binary.text = octalToOtherSystem(value, 2);
                    decimal.text = octalToOtherSystem(value, 10);
                    hexadecimal.text = octalToOtherSystem(value, 16);
                  }
                },
                decoration: InputDecoration(
                    labelText: "Octal",
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.blueAccent))),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: decimal,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]*\.?[0-9]{0,16}')),
                ],
                style: TextStyle(fontSize: 25),
                onChanged: (value) {
                  if (searchFunction(value, '.')) {
                    if (value[value.indexOf('.')] != value[value.length - 1]) {
                      binary.text = decimalFraction(value, 2);
                      octal.text = decimalFraction(value, 8);
                      hexadecimal.text = decimalFraction(value, 16);
                    } else {
                      binary.text = decimalToOtherSystem(
                          value.substring(0, value.indexOf('.')), 2);
                      octal.text = decimalToOtherSystem(
                          value.substring(0, value.indexOf('.')), 8);
                      hexadecimal.text = decimalToOtherSystem(
                          value.substring(0, value.indexOf('.')), 16);
                    }
                  } else if (value == "") {
                    binary.text = "";
                    octal.text = "";
                    hexadecimal.text = "";
                  } else {
                    binary.text = decimalToOtherSystem(value, 2);
                    octal.text = decimalToOtherSystem(value, 8);
                    hexadecimal.text = decimalToOtherSystem(value, 16);
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  labelText: "Decimal",
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(fontSize: 25),
                controller: hexadecimal,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9a-fA-F]*\.?[0-9a-fA-F]{0,16}')),
                ],
                onChanged: (value) {
                  hexadecimal.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: hexadecimal.selection);
                  if (searchFunction(value, '.')) {
                    if (value[value.indexOf('.')] != value[value.length - 1]) {
                      binary.text = hexadecimalFraction(value, 2);
                      octal.text = hexadecimalToOtherSystem(
                              value.substring(0, value.indexOf('.')), 8) +
                          '.' +
                          hexadecimalFraction(value, 8);
                      decimal.text = hexadecimalFraction(value, 10);
                    } else {
                      binary.text = hexadecimalToOtherSystem(
                          value.substring(0, value.indexOf('.')), 2);
                      octal.text = hexadecimalToOtherSystem(
                          value.substring(0, value.indexOf('.')), 8);
                      decimal.text = hexadecimalToOtherSystem(
                          value.substring(0, value.indexOf('.')), 10);
                    }
                  } else if (value == "") {
                    binary.text = "";
                    octal.text = "";
                    decimal.text = "";
                  } else {
                    binary.text = hexadecimalToOtherSystem(value, 2);
                    octal.text = hexadecimalToOtherSystem(value, 8);
                    decimal.text = hexadecimalToOtherSystem(value, 10);
                  }
                },
                decoration: InputDecoration(
                    labelText: "Hexadecimal",
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.blueAccent))),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
