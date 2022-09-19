import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_feature/domain/model/pokemon_model.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture_provider.dart';
import 'package:pokedex/pokemon_detail_feature/domain/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

class WildPokemon extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  WildPokemon({
    Key? key,
    required this.pokemon,
    required this.captureProvider,
  }) : super(key: key);

  final PokemonModel pokemon;
  final PokemonCaptureProvider captureProvider;

  String get capturedText => pokemon.captured ? 'Captured' : '';

  void capturePokemon(BuildContext context) {
    final pokemonProvider = context.read<PokemonProvider>();
    captureProvider.updateCapture(pokemon);
    captureProvider
        .updateCapturedPokemons(pokemonProvider.paginatedPokemons);
  }

  @override
  Widget build(BuildContext context) {
    final captured = pokemon.captured
        ? captureProvider.trainerStatus.color
        : TrainerStatus.starter.color;
    return Container(
      width: 150,
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
                    onTap: () => capturePokemon(context),
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
          Image.network(
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
