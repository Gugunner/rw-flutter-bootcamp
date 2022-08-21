import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail.dart';
import 'package:pokedex/pokemon_model.dart';
import 'package:pokedex/fake_repository.dart';

void main() {
  runApp(const MaterialApp(
    title: "Pokedex Sample",
    home: Pokedex(),
  ));
}

class Pokedex extends StatefulWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  List<PokemonModel> pokemons = [];
  final fakeRepository = FakePokemonRepository();

  @override
  void initState() {
    super.initState();
    pokemons = fakeRepository.getFakePokedex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex Sample"),
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(8.0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            ...pokemons.map((pokemon) => PokemonCard(pokemon: pokemon))
          ],
        ),
      ),
    );
  }
}

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
        shadowColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        elevation: 3.0,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 200, 193, 253).withOpacity(0.3),
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
