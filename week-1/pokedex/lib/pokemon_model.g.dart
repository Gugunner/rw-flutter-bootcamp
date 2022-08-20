// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) => PokemonModel(
      num: json['num'] as String,
      name: json['name'] as String,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      location:
          (json['location'] as List<dynamic>).map((e) => e as int).toList(),
      img: json['img'] as String,
    );

Map<String, dynamic> _$PokemonModelToJson(PokemonModel instance) =>
    <String, dynamic>{
      'num': instance.num,
      'name': instance.name,
      'type': instance.type,
      'location': instance.location,
      'img': instance.img,
    };
