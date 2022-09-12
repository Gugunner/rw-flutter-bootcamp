void main() {
  final instance = Assignment2.instance;
  final upperCasePokemons = instance.withUpperCasePokemons(instance.pokemons);
  instance.sortAlphabeticallyPokemons(upperCasePokemons);
  instance.printSortedPokemonsByType();
}

class Assignment2 {
  final pokemons = <String>[
    'bulbasaur',
    'squirtle',
    'charmander',
    'caterpie',
    'metapod',
    'butterfree',
    'weedle',
    'kakuan',
    'beedrill'
  ];

  final pokemonsMap = <Map<String, dynamic>>[
    {
      'name': 'Bulbasaur',
      'type': 'grass',
      'speed': 30,
    },
    {
      'name': 'Squirtle',
      'type': 'water',
      'speed': 24,
    },
    {
      'name': 'Charmander',
      'type': 'fire',
      'speed': 40,
    },
    {
      'name': 'Venusaur',
      'type': 'grass',
      'speed': 40,
    },
    {
      'name': 'Caterpie',
      'type': 'bug',
      'speed': 30,
    },
    {
      'name': 'Pidgey',
      'type': 'flying',
      'speed': 30,
    },
    {
      'name': 'Pikachu',
      'type': 'electric',
      'speed': 50,
    },
    {
      'name': 'Raichu',
      'type': 'electric',
      'speed': 60,
    },
    {
      'name': 'Rattata',
      'type': 'normal',
      'speed': 40,
    },
    {
      'name': 'Charmelion',
      'type': 'fire',
      'speed': 40,
    },
    {
      'name': 'Charizard',
      'type': 'fire',
      'speed': 50,
    },
    {
      'name': 'Spearow',
      'type': 'flying',
      'speed': 40,
    },
    {
      'name': 'Oddish',
      'type': 'grass',
      'speed': 20,
    },
    {
      'name': 'Poliwag',
      'type': 'water',
      'speed': 50,
    },
    {
      'name': 'Poliwhirl',
      'type': 'water',
      'speed': 50,
    },
  ];

  static final instance = Assignment2();

  List<String> withUpperCasePokemons(List<String> pokemons) {
    final upperCasePokemons = [
      for (var pokemon in pokemons) pokemon.toUpperCase()
    ];
    print('Upper case pokemons => $upperCasePokemons');
    return upperCasePokemons;
  }

  void sortAlphabeticallyPokemons(List<String> pokemons) {
    List<String> sortedPokemons = pokemons;
    sortedPokemons.sort();
    print('Alphabetically sorted pokemons => $sortedPokemons');
  }

  Set<String> get types => pokemonsMap.map((p) => p['type'] as String).toSet();

  List<Map<String, dynamic>> sortByType(String type) {
    final sortedPokemon = pokemonsMap.where((p) => p['type'] == type).toList();
    sortedPokemon.sort((p1, p2) {
      final p1Name = p1['name'] as String;
      final p2Name = p2['name'] as String;
      return p1Name.compareTo(p2Name);
    });
    return sortedPokemon;
  }

  void printSortedPokemonsByType() {
    for (final type in types) {
      final typePokemon = instance.sortByType(type);
      print('Alphabetically sorted $type pokemons => $typePokemon');
    }
  }
}
