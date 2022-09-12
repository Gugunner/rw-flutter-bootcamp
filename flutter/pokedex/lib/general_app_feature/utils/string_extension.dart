extension StrinCapitals on String {
  String get allCapitals {
    final splitString = trim().split(RegExp(r'\s+'));
    return splitString.map((s) => s.capitalOne.trim()).join(' ');
  }

  String get capitalOne => substring(0, 1).toUpperCase() + substring(1);
}
