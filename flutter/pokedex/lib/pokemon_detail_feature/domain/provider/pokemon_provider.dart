import 'package:flutter/material.dart';
import 'package:pokedex/general_app_feature/data/paginated_repository.dart';
import 'package:pokedex/general_app_feature/utils/pokemon_search.dart';
import 'package:pokedex/pokemon_detail_feature/domain/model/pokemon_model.dart';

enum PokemonListType {
  idle,
  search,
  captured,
}

class PokemonProvider extends ChangeNotifier {
  PokemonProvider(this.repository);

  final PaginatedRepository repository;

  final TextEditingController searchController = TextEditingController();

  PokemonListType _pokemonListType = PokemonListType.idle;
  PokemonListType get pokemonListType => _pokemonListType;
  set pokemonListType(PokemonListType type) {
    _pokemonListType = type;
    notifyListeners();
  }

  List<PokemonModel> allPokemons = <PokemonModel>[];

  List<PokemonModel> paginatedPokemons = <PokemonModel>[];

  List<PokemonModel> _currentPokemons = <PokemonModel>[];

  List<PokemonModel> get currentPokemons => _currentPokemons;

  void updateCurrentPokemons() {
    _currentPokemons = pokemonListType == PokemonListType.search
        ? searchPokemons()
        : paginatedPokemons;
    notifyListeners();
  }

  String searchTerm = '';

  int currentPage = 0;

  int perPage = 56;

  bool errorLoading = false;

  int get totalPokemons => allPokemons.length;

  int get nextStartPosition {
    final currentLastPosition = totalPokemons - (currentPage * perPage);
    if (currentLastPosition <= 0) {
      return -1;
    }
    return (currentPage * perPage);
  }

  int get nextEndPosition {
    if (totalPokemons - (currentPage * perPage) > 0) {
      return currentPage * perPage;
    }
    return totalPokemons;
  }

  Future<void> retrievePokemons() async {
    try {
      final data = await repository.getAllPaginated(0);
      allPokemons = data.map((d) => PokemonModel.fromJson(d)).toList();
    } catch (e) {
      errorLoading = true;
    }
  }

  Future<void> retrievePokemonsByPosition([int? start, int? end]) async {
    try {
      final startPosition = start ?? nextStartPosition;
      if (startPosition < 0) {
        return;
      }
      currentPage++;
      final endPosition = end ?? nextEndPosition;
      final data = await repository.getAllPaginated(startPosition, endPosition);
      final newPaginatedPokemons =
          data.map((d) => PokemonModel.fromJson(d)).toList();
      paginatedPokemons = [...paginatedPokemons, ...newPaginatedPokemons];
    } catch (e) {
      errorLoading = true;
    }

    notifyListeners();
  }

  Future<void> retrieveInitialPokemons() async {
    await retrievePokemons();
    await retrievePokemonsByPosition(0, perPage);
    updateCurrentPokemons();
  }
}

extension SearchPokemon on PokemonProvider {
  List<PokemonModel> searchPokemons() {
    if (searchTerm.isEmpty) {
      cleanSearch();
    }
    final pokemonsByName = PokemonSearch.searchBy(SearchBy.name,
        pokemons: paginatedPokemons, value: searchTerm);
    final pokemonsByType = PokemonSearch.searchBy(SearchBy.type,
        pokemons: paginatedPokemons, value: searchTerm);
    final searchablePokemons = <PokemonModel>[
      ...pokemonsByName,
      ...pokemonsByType
    ];
    if (searchablePokemons.isNotEmpty) {
      return searchablePokemons;
    }
    return [];
  }

  void cleanSearch() {
    searchController.text = '';
    pokemonListType = PokemonListType.idle;
  }
}
