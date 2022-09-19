import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/general_app_feature/utils/types.dart';
part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  PokemonModel({
    required this.name,
    required this.num,
    required this.types,
    required this.img,
    required this.entry,
    this.captured = false,
  });

  final String name;
  @JsonKey(
    name: 'id',
  )
  final String num;
  @JsonKey(
    name: 'typeofpokemon',
    fromJson: toPokemonType,
    toJson: fromPokemonType,
  )
  final List<PokemonType> types;
  @JsonKey(
    name: 'imageurl',
  )
  final String img;
  @JsonKey(
    name: 'xdescription',
  )
  final String entry;
  bool captured;

  static List<PokemonType> toPokemonType(List<dynamic> type) {
    return type
        .map((t) => PokemonType.values.firstWhere(
            (v) => v.name == t.toLowerCase(),
            orElse: () => PokemonType.unknown))
        .toList();
  }

  static List<String> fromPokemonType(List<PokemonType> types) =>
      types.map((t) => t.name).toList();

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
}
