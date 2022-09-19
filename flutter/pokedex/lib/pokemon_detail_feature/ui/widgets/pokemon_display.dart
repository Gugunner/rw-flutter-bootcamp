import 'package:flutter/material.dart';
import 'package:pokedex/general_app_feature/utils/build_context.dart';
import 'package:pokedex/pokemon_detail_feature/domain/model/pokemon_model.dart';

class Display extends StatelessWidget {
  const Display({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Hero(
          tag: pokemon.num,
          child: Card(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 227, 224, 249).withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              ),
              width: context.width * 0.386,
              child: Image.network(
                pokemon.img,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(8.0),
              width: context.width * 0.338,
              height: context.height * 0.146,
              child: Information(pokemon: pokemon)),
        )
      ],
    );
  }
}

class Information extends StatelessWidget {
  const Information({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pokedex international number: ${pokemon.num}',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          textAlign: TextAlign.start,
        ),
        Text(
          pokemon.entry,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 10,
          ),
          softWrap: true,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
