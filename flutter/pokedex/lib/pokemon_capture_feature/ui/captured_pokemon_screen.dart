import 'package:flutter/material.dart';
import 'package:pokedex/general_app_feature/utils/build_context.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture_provider.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/pokemon_card.dart';

class CapturedPokemonScreen extends StatelessWidget {
  CapturedPokemonScreen({
    Key? key,
    required this.captureProvider,
  }) : super(key: key);

  final PokemonCaptureProvider captureProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pokemon'),
        backgroundColor: Colors.orange,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            final capturedPokemon = captureProvider.capturedPokemons[index];
            return SizedBox(
              height: context.height * 0.3,
              child: Column(
                children: [
                  Expanded(
                    child: Dismissible(
                        key: ValueKey(capturedPokemon.num),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          width: context.width,
                          color: const Color.fromARGB(255, 255, 140, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SwipeBackground(),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Bye Bye!\n ${capturedPokemon.name.toUpperCase()}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SwipeBackground(),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          captureProvider.updateCapture(capturedPokemon);
                          captureProvider.updateCapturedPokemons(
                              captureProvider.capturedPokemons);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.orange,
                              content: Text(
                                  'You have released ${capturedPokemon.name}!')));
                        },
                        child: PokemonCard(
                          pokemon: capturedPokemon,
                          captureProvider: captureProvider,
                        )),
                  ),
                ],
              ),
            );
          }, childCount: captureProvider.capturedPokemons.length)),
        ],
      ),
    );
  }
}

class SwipeBackground extends StatelessWidget {
  const SwipeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      alignment: Alignment.bottomCenter,
      width: context.height * 0.16,
      height: context.height * 0.16,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.catching_pokemon_outlined,
              color: Colors.white,
            ),
            Text('Release pokemon!'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ]),
    );
  }
}
