import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture.dart';
import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';
import 'package:pokedex/pokemon_detail_feature/ui/pokemon_detail_screen.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/wild_pokemon.dart';
import 'package:pokedex/pokemon_capture_feature/ui/widgets/captured_pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    required this.pokemon,
    this.capturePokemon,
    required this.capturedPokemonProvider,
  }) : super(key: key);

  final PokemonModel pokemon;
  final Function(PokemonModel pokemon)? capturePokemon;
  final PokemonCaptureProvider capturedPokemonProvider;

  bool get isWild => capturePokemon != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Detail(pokemon: pokemon);
        }));
      },
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
                capturePokemon: capturePokemon,
                capturedPokemonProvider: capturedPokemonProvider,
              )
            : CapturedPokemon(pokemon: pokemon),
      ),
    );
  }
}
