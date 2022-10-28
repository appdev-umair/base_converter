bool searchFunction(String myString, String searchValue) {
  if (myString == searchValue) {
    return true;
  }
  int count = 0;
  var searchFor = searchValue.split(" ");
  for (final searchWord in searchFor) {
    if (myString.contains(searchWord)) {
      count++;
    }
  }
  return count == searchFor.length;
}

String octalMaker(String oct) {
  if (oct.length % 3 == 0) {
    return oct;
  } else {
    while (oct.length % 3 != 0) {
      oct = "${oct}0";
    }
  }
  return oct;
}

String hexaMaker(String hexa) {
  if (hexa.length % 4 == 0) {
    return hexa;
  } else {
    while (hexa.length % 4 != 0) {
      hexa = "${hexa}0";
    }
  }
  return hexa;
}

