import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokedex/general_app_feature/api/app_api_dio_exceptions.dart';
import 'package:pokedex/general_app_feature/data/paginated_repository.dart';
import 'package:pokedex/pokemon_detail_feature/data/api/pokemon_api.dart';
import 'package:pokedex/pokemon_detail_feature/domain/model/pokemon_model.dart';

///An implementation of the [PaginatedRepository] for
///retrieving pokemon information that conforms to the [PokemonModel].
class PokemonRepository implements PaginatedRepository {
  PokemonRepository(this.pokemonApi);

  ///An implementation of the api.
  final PokemonApi pokemonApi;

  @override
  Future<List<dynamic>> getAllPaginated(int start, [int? end]) async {
    try {
      final response = await pokemonApi.getPokemonsApi<Response>();
      final statusCode = response.statusCode ?? HttpStatus.internalServerError;
      if (statusCode == HttpStatus.ok) {
        if (response.data != null) {
          final data = jsonDecode(response.data);
          if (data is List) {
            //This is a demo to show pagination, pagination should be implemented as a web service
            return data.sublist(start, end);
          }
        }
      }
      throw Exception(
          'There is no status code, no data in response, or data is not of type list');
    } catch (e) {
      if (e is DioError) {
        final errorMessages = AppDioApiExceptions.fromDioError(e);
        throw errorMessages;
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> getEntity(String id) async {
    final pokemonList = getAllPaginated(0) as List<PokemonModel>;
    final pokemon = pokemonList.firstWhere((p) => id == p.num);
    return pokemon;
  }

  @override
  Future<int> getTotalPages() {
    // TODO: implement getTotalPages
    throw UnimplementedError();
  }
}
