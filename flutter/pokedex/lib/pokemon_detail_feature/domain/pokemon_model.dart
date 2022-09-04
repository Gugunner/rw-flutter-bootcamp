import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/general_app_feature/utils/types.dart';
part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  PokemonModel({
    required this.num,
    required this.name,
    required this.types,
    required this.locations,
    required this.img,
    this.entry,
  });

  final String num;
  final String name;
  @JsonKey(
    name: 'type',
    fromJson: toPokemonType,
    toJson: fromPokemonType,
  )
  final List<PokemonType> types;
  final List<List<double>> locations;
  final String img;
  final String? entry;

  static List<PokemonType> toPokemonType(List<String> type) {
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
