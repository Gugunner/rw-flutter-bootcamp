import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/general_app_feature/api/app_dio_api.dart';
import 'package:pokedex/home.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture_provider.dart';
import 'package:pokedex/pokemon_detail_feature/data/api/pokemon_api.dart';
import 'package:pokedex/pokemon_detail_feature/data/repository/pokemon_repository.dart';
import 'package:pokedex/pokemon_detail_feature/domain/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Pokedex());
}

class Pokedex extends StatefulWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Sample',
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
            create: (ctx) => PokemonProvider(
                PokemonRepository(PokemonApi(api: AppDioApi(Dio()))))),
        ChangeNotifierProvider(create: (ctx) => PokemonCaptureProvider())
      ], child: const Home()),
    );
  }
}
