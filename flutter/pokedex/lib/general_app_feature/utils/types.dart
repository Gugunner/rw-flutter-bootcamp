import 'package:flutter/material.dart';

enum PokemonType {
  grass,
  poison,
  water,
  fire,
  ground,
  psychic,
  electricity,
  unknown,
}

extension PokemonTypeExtends on PokemonType {
  String get displayValue =>
      name.substring(0, 1).toUpperCase() + name.substring(1);
}

class TagTypes {
  static Color tagColor(PokemonType type) {
    switch (type) {
      case PokemonType.grass:
        return Colors.green;
      case PokemonType.poison:
        return const Color.fromARGB(255, 223, 67, 251);
      case PokemonType.water:
        return Colors.blue;
      case PokemonType.fire:
        return Colors.red;
      case PokemonType.ground:
        return const Color.fromARGB(255, 169, 129, 68);
      case PokemonType.psychic:
        return const Color.fromARGB(255, 103, 0, 110);
      default:
        return const Color.fromARGB(255, 62, 62, 62);
    }
  }
}
