import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';

enum SearchBy {
  name,
  type,
}

class PokemonSearch {
  static List<PokemonModel> _searchByName(
      {required List<PokemonModel> pokemons, required String value}) {
    final filteredPokemons = pokemons
        .where((p) => p.name.toLowerCase().contains(value.toLowerCase()));
    if (filteredPokemons.isEmpty) {
      return [];
    }
    return filteredPokemons.toList();
  }

  static List<PokemonModel> _searchByType(
      {required List<PokemonModel> pokemons, required String value}) {
    final filteredPokemons = pokemons.where((p) {
      final types = p.types.map((t) => t.name.toLowerCase());
      return types.any((t) => t.contains(value.toLowerCase()));
    });
    if (filteredPokemons.isEmpty) {
      return [];
    }
    return filteredPokemons.toList();
  }

  static List<PokemonModel> searchBy(SearchBy by,
      {required List<PokemonModel> pokemons, required String value}) {
    switch (by) {
      case SearchBy.name:
        return _searchByName(pokemons: pokemons, value: value);
      case SearchBy.type:
        return _searchByType(pokemons: pokemons, value: value);
    }
  }
}
