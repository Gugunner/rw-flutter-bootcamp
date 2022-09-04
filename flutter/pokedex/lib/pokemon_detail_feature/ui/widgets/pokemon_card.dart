import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';
import 'package:pokedex/pokemon_detail_feature/ui/pokemon_detail_screen.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

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
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 227, 224, 249).withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
        ),
      ),
    );
  }
}
