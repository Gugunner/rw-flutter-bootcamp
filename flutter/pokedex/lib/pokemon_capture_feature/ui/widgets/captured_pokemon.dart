import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture.dart';

class CapturedPokemon extends StatelessWidget {
  const CapturedPokemon({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 227, 224, 249).withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.catching_pokemon_outlined,
                    color: TrainerStatus.amateur.color,
                  ),
                ],
              ),
            ],
          ),
          Image.asset(
            pokemon.img,
            width: 90,
          ),
          Text(
            pokemon.num,
          ),
          Text(pokemon.name)
        ],
      ),
    );
  }
}
