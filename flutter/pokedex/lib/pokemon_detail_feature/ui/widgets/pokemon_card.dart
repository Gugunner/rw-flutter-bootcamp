import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture_provider.dart';
import 'package:pokedex/pokemon_detail_feature/domain/model/pokemon_model.dart';
import 'package:pokedex/pokemon_detail_feature/ui/pokemon_detail_screen.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/wild_pokemon.dart';
import 'package:pokedex/pokemon_capture_feature/ui/widgets/captured_pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    required this.pokemon,
    required this.captureProvider,
  }) : super(key: key);

  final PokemonModel pokemon;
  final PokemonCaptureProvider captureProvider;

  bool get isWild => !pokemon.captured;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(seconds: 2),
            reverseTransitionDuration: const Duration(seconds: 2),
            pageBuilder: (context2, animation1, animation2) {
              return Detail(pokemon: pokemon);
            }));
      },
      child: Hero(
        tag: pokemon.num,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.orange,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          elevation: 3.0,
          child: isWild
              ? WildPokemon(
                  pokemon: pokemon,
                  captureProvider: captureProvider,
                )
              : CapturedPokemon(pokemon: pokemon),
        ),
      ),
    );
  }
}
