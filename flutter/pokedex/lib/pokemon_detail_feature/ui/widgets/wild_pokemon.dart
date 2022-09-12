import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture.dart';

class WildPokemon extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  WildPokemon({
    Key? key,
    required this.pokemon,
    this.capturePokemon,
    required this.capturedPokemonProvider,
  }) : super(key: key);

  final PokemonModel pokemon;
  final Function(PokemonModel pokemon)? capturePokemon;
  final PokemonCaptureProvider capturedPokemonProvider;

  Color get captured => pokemon.captured
      ? capturedPokemonProvider.trainerStatus.color
      : TrainerStatus.starter.color;

  String get capturedText => pokemon.captured ? 'Captured' : '';

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
                  GestureDetector(
                    onTap: () => capturePokemon?.call(pokemon),
                    child: Icon(
                      Icons.catching_pokemon_outlined,
                      color: captured,
                    ),
                  ),
                  Text(
                    capturedText,
                    style: const TextStyle(fontSize: 10),
                  )
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
