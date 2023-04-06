import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'logic/binary.dart';
import 'logic/decimal.dart';
import 'logic/funcions.dart';
import 'logic/hexadecimal.dart';
import 'logic/octal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const Converter(),
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
        title: const Text("Base Converter"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                binary.text = "";
                octal.text = "";
                decimal.text = "";
                hexadecimal.text = "";
              },
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashRadius: 20,
              icon: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: binary,
                      style: const TextStyle(fontSize: 25),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Binary",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-1][0-1]*(\.[0-1]{0,64})?')),
                      ],
                      onChanged: (value) {
                        if (searchFunction(value, '.')) {
                          if (value[value.indexOf('.')] !=
                              value[value.length - 1]) {
                            if (binaryFraction(value, 8).length >= 16) {
                              octal.text =
                                  '${binaryToOtherSystem(value.substring(0, value.indexOf('.')), 8)}.${binaryFraction(value, 8).substring(0, 16)}';
                            } else {
                              octal.text =
                                  '${binaryToOtherSystem(value.substring(0, value.indexOf('.')), 8)}.${binaryFraction(value, 8)}';
                            }
                            decimal.text = binaryFraction(value, 10);
                            if (binaryFraction(value, 16).length >= 16) {
                              hexadecimal.text =
                                  '${binaryToOtherSystem(value.substring(0, value.indexOf('.')), 16)}.${binaryFraction(value, 16).substring(0, 16).toUpperCase()}';
                            } else {
                              hexadecimal.text =
                                  '${binaryToOtherSystem(value.substring(0, value.indexOf('.')), 16)}.${binaryFraction(value, 16).toUpperCase()}';
                            }
                          }
                        } else if (value == "") {
                          octal.text = "";
                          decimal.text = "";
                          hexadecimal.text = "";
                        } else {
                          octal.text = binaryToOtherSystem(value, 8);
                          decimal.text = binaryToOtherSystem(value, 10);
                          hexadecimal.text =
                              binaryToOtherSystem(value, 16).toUpperCase();
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: octal,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-7][0-7]*([.][0-7]{0,24})?')),
                      ],
                      style: const TextStyle(fontSize: 25),
                      onChanged: (value) {
                        if (searchFunction(value, '.')) {
                          if (value[value.indexOf('.')] !=
                              value[value.length - 1]) {
                            binary.text = octalFraction(value, 2);
                            decimal.text = octalFraction(value, 10);
                            hexadecimal.text =
                                '${octalToOtherSystem(value.substring(0, value.indexOf('.')), 16)}.${octalFraction(value, 16).toUpperCase()}';
                          }
                        } else if (value == "") {
                          binary.text = "";
                          decimal.text = "";
                          hexadecimal.text = "";
                        } else {
                          binary.text = octalToOtherSystem(value, 2);
                          decimal.text = octalToOtherSystem(value, 10);
                          hexadecimal.text =
                              octalToOtherSystem(value, 16).toUpperCase();
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Octal",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: decimal,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9][0-9]*([.][0-9]{0,16})?'),
                        ),
                      ],
                      style: const TextStyle(fontSize: 25),
                      onChanged: (value) {
                        if (searchFunction(value, '.')) {
                          if (value[value.indexOf('.')] !=
                              value[value.length - 1]) {
                            binary.text = decimalFraction(value, 2);
                            octal.text = decimalFraction(value, 8);
                            hexadecimal.text =
                                decimalFraction(value, 16).toUpperCase();
                          } else {
                            binary.text = decimalToOtherSystem(
                                value.substring(0, value.indexOf('.')), 2);
                            octal.text = decimalToOtherSystem(
                                value.substring(0, value.indexOf('.')), 8);
                            hexadecimal.text = decimalToOtherSystem(
                                    value.substring(0, value.indexOf('.')), 16)
                                .toUpperCase();
                          }
                        } else if (value == "") {
                          binary.text = "";
                          octal.text = "";
                          hexadecimal.text = "";
                        } else {
                          binary.text = decimalToOtherSystem(value, 2);
                          octal.text = decimalToOtherSystem(value, 8);
                          hexadecimal.text =
                              decimalToOtherSystem(value, 16).toUpperCase();
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Decimal",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 25),
                      controller: hexadecimal,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              r'^[0-9a-fA-F][0-9a-fA-F]*([.][0-9a-fA-F]{0,16})?'),
                        ),
                      ],
                      onChanged: (value) {
                        hexadecimal.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: hexadecimal.selection);
                        if (searchFunction(value, '.')) {
                          if (value[value.indexOf('.')] !=
                              value[value.length - 1]) {
                            binary.text = hexadecimalFraction(value, 2);
                            octal.text =
                                '${hexadecimalToOtherSystem(value.substring(0, value.indexOf('.')), 8)}.${hexadecimalFraction(value, 8)}';
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
