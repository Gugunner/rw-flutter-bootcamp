// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) => PokemonModel(
      num: json['num'] as String,
      name: json['name'] as String,
      types: PokemonModel.toPokemonType(json['type'] as List<String>),
      locations: (json['locations'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
      img: json['img'] as String,
      entry: json['entry'] as String?,
    );

Map<String, dynamic> _$PokemonModelToJson(PokemonModel instance) =>
    <String, dynamic>{
      'num': instance.num,
      'name': instance.name,
      'type': PokemonModel.fromPokemonType(instance.types),
      'locations': instance.locations,
      'img': instance.img,
      'entry': instance.entry,
    };
