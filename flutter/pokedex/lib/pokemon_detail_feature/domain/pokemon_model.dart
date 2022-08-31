import 'package:json_annotation/json_annotation.dart';
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
  )
  final List<String> types;
  final List<List<double>> locations;
  final String img;
  final String? entry;
  // ignore: todo
  //TODO: Add a description property

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
}
