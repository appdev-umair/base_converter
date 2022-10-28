import 'package:flutter/material.dart';

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
      theme: ThemeData.dark(),
      home: Converter(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Converter"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.center,
                controller: binary,
                decoration: InputDecoration(
                  hintText: "Binary",
                ),
                onChanged: (value) {
                  if (searchFunction(value, '.')) {
                    octal.text = binaryFraction(value, 8);
                    decimal.text = binaryFraction(value, 10);
                    hexadecimal.text = binaryFraction(value, 16);
                  }
                  else if (value == ""){
                    octal.text = "";
                    decimal.text = "";
                    hexadecimal.text = "";
                  }
                  else {
                    octal.text = binaryToOtherSystem(value, 8);
                    decimal.text = binaryToOtherSystem(value, 10);
                    hexadecimal.text = binaryToOtherSystem(value, 16);
                  }
                },
              ),
              TextField(
                controller: octal,
                onChanged: (value) {
                  if (searchFunction(value, '.')) {
                    binary.text = octalFraction(value, 2);
                    decimal.text = octalFraction(value, 10);
                    hexadecimal.text = octalFraction(value, 16);
                  }
                  else if (value == ""){
                    binary.text = "";
                    decimal.text = "";
                    hexadecimal.text = "";
                  }
                  else {
                    binary.text = octalToOtherSystem(value, 2);
                    decimal.text = octalToOtherSystem(value, 10);
                    hexadecimal.text = octalToOtherSystem(value, 16);
                  }
                },
                decoration: InputDecoration(
                  hintText: "Octal",
                ),
              ),
              TextField(
                controller: decimal,
                onChanged: (value) {
                  if (searchFunction(value, '.')) {
                    binary.text = decimalFraction(value, 2);
                    octal.text = decimalFraction(value, 8);
                    hexadecimal.text = decimalFraction(value, 16);
                  }
                  else if (value == ""){
                    binary.text = "";
                    octal.text = "";
                    hexadecimal.text = "";

                  }
                  else {
                    binary.text = decimalToOtherSystem(value, 2);
                    octal.text = decimalToOtherSystem(value, 8);
                    hexadecimal.text = decimalToOtherSystem(value, 16);
                  }
                },
                decoration: InputDecoration(
                  hintText: "Decimal",
                ),
              ),
              TextField(
                controller: hexadecimal,
                onChanged: (value) {

                  if (searchFunction(value, '.')) {

                    binary.text = hexadecimalFraction(value, 2);
                    octal.text = hexadecimalFraction(value, 8);
                    decimal.text = hexadecimalFraction(value, 10);
                  }
                  else if (value == ""){
                    binary.text = "";
                    octal.text = "";
                    decimal.text = "";
                  }
                  else {
                    binary.text = hexadecimalToOtherSystem(value, 2);
                    octal.text = hexadecimalToOtherSystem(value, 8);
                    decimal.text = hexadecimalToOtherSystem(value, 10);
                  }
                },
                decoration: InputDecoration(
                  hintText: "Hexadecimal",
                ),
              )



            ],
          ),
        )
      ),
    );
  }

}
