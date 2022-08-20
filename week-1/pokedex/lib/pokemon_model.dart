import 'package:json_annotation/json_annotation.dart';
part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  PokemonModel({
    required this.num,
    required this.name,
    required this.type,
    required this.location,
    required this.img,
  });

  final String num;
  final String name;
  final List<String> type;
  final List<int> location;
  final String img;

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);
    
}

