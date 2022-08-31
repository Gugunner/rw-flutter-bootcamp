import 'package:flutter/material.dart';

class TagTypes {
  static Color tagColor(String type) {
    switch (type.toLowerCase()) {
      case "grass":
        return Colors.green;
      case 'poison':
        return const Color.fromARGB(255, 223, 67, 251);
      case 'water':
        return Colors.blue;
      case 'fire':
        return Colors.red;
      case 'ground':
        return const Color.fromARGB(255, 169, 129, 68);
      case 'psychic':
        return const Color.fromARGB(255, 103, 0, 110);
      default:
        return const Color.fromARGB(255, 62, 62, 62);
    }
  }
}
