// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) => PokemonModel(
      name: json['name'] as String,
      num: json['id'] as String,
      types: PokemonModel.toPokemonType(json['typeofpokemon'] as List),
      img: json['imageurl'] as String,
      entry: json['xdescription'] as String,
      captured: json['captured'] as bool? ?? false,
    );

Map<String, dynamic> _$PokemonModelToJson(PokemonModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.num,
      'typeofpokemon': PokemonModel.fromPokemonType(instance.types),
      'imageurl': instance.img,
      'xdescription': instance.entry,
      'captured': instance.captured,
    };
