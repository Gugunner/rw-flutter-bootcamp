import 'package:flutter/material.dart';
import 'package:pokedex/home.dart';

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
    return const MaterialApp(
      title: "Pokedex Sample",
      home: Home(),
    );
  }
}
