import 'package:flutter/material.dart';
import 'package:pokedex/home.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture.dart';
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
        ChangeNotifierProvider(create: (ctx) => PokemonCaptureProvider())
      ], child: const Home()),
    );
  }
}
