import 'package:pokedex/general_app_feature/api/app_api.dart';
import 'package:pokedex/general_app_feature/api/endpoints.dart';

///Handles all the calls for obtaining the general and detailed information of a pokemon.
class PokemonApi {
  PokemonApi({
    required this.api,
  });

  ///The AppApi injection to call all the methods
  final AppApi api;

  ///Simple call that calls all pokemon without any pagination
  Future<T> getPokemonsApi<T>() async {
    try {
      ///Leave response so you can debug it in this point
      final response = await api.get(Endpoints.pokemonsUrl);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
