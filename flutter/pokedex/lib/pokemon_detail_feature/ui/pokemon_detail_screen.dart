import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/pokemon_display.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/pokemon_map.dart';
import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/pokemon_types.dart';

class Detail extends StatelessWidget {
  const Detail({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(pokemon: pokemon),
                Display(pokemon: pokemon),
                Types(types: pokemon.types),
                Expanded(
                  child: Location(locations: pokemon.locations),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '${pokemon.num} ${pokemon.name}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(color: Colors.orange)),
          child: Image.asset(
            'assets/pokeball.png',
            width: 35,
            height: 35,
          ),
        ),
      ],
    );
  }
}
