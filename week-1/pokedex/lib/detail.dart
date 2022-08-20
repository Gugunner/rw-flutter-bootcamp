import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_model.dart';

class Detail extends StatelessWidget {
  const Detail({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${pokemon.num} ${pokemon.name}',
      )),
      body: Container(
        color: Colors.orange,
      ),
    );
  }
}
