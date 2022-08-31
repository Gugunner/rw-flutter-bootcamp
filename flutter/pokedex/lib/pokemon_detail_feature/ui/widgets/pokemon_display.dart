import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';

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
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 227, 224, 249).withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          width: 140,
          height: 100,
          child: Image.asset(
            pokemon.img,
          ),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(8.0),
              width: 140,
              height: 100,
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
          entry(),
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

  String entry() {
    return pokemon.entry ??
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
            'Praesent egestas elit eget nisl varius, a mollis sem placerat.'
            'Donec felis erat, Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
  }
}
