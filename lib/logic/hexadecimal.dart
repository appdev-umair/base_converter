import 'binary.dart';

String hexadecimalToOtherSystem(String hex, int base) {
  int decimal_of_binary = int.parse('$hex', radix: 16);
  if (base == 2)
    return decimal_of_binary.toRadixString(2);
  else if (base == 8) return decimal_of_binary.toRadixString(8);
  return decimal_of_binary.toString();
}

String hexadecimalFraction(String hex, int base) {
  String hexFraction = hex.substring(hex.indexOf('.') + 1, hex.length);
  String binFrac = "";
  hex = hex.substring(0, hex.indexOf('.'));
  for (var i = 0; i < hexFraction.length; i++) {
    binFrac +=
        int.parse(hexFraction[i], radix: 16).toRadixString(2).padLeft(4, '0');
  }
  while (binFrac[binFrac.length - 1] != '1') {
    binFrac = binFrac.substring(0, binFrac.length - 1);
  }
  String binWhole = hexadecimalToOtherSystem(hex, 2);
  return binaryFraction(binWhole + '.' + binFrac, base);
}