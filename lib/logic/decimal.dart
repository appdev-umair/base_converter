import 'binary.dart';

String decimalToOtherSystem(String decimal, int base) {
  return int.parse(decimal, radix: 10).toRadixString(base);
}

String decimalFraction(String decimal, int base) {
  String fraction = decimal.substring(decimal.indexOf('.'), decimal.length);
  String whole = decimal.substring(0, decimal.indexOf('.'));
  double frac = double.parse(fraction);
  String fracStr = "";
  String binDig = "";
  do {
    frac = frac * base;
    fracStr = frac.toString();
    frac =
        double.parse(fracStr.substring(fracStr.indexOf('.'), fracStr.length));
    String dig = fracStr.substring(0, fracStr.indexOf('.'));
    if (base == 16) {
      binDig += int.parse(dig).toRadixString(16).toUpperCase();
    } else
      binDig += dig;
    if (binDig.length == 16) {
      break;
    }
  } while (frac != 0);
  String binWhole = int.parse(whole).toRadixString(base).toUpperCase();
  String binDeci = binWhole + '.' + binDig;

  return binDeci;
}
