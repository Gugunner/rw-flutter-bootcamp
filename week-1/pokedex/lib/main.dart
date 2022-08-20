import 'package:flutter/material.dart';
import 'package:pokedex/detail.dart';
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
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < 20; i++) {
      pokemons = [...pokemons, ...fakeRepository.getFakePokedex()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex Sample"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 52, 159, 139),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(8.0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[...pokemonCards()],
        ),
      ),
    );
  }

  List<Widget> pokemonCards() {
    return pokemons
        .map((pokemon) => GestureDetector(
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
                    side: BorderSide(
                      width: 4.0,
                      style: BorderStyle.solid,
                      color: Color.fromARGB(255, 39, 126, 176),
                    )),
                elevation: 5.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 176, 166, 254)
                        .withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        pokemon.img,
                      ),
                      Text(
                        pokemon.num,
                      ),
                      Text(pokemon.name)
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }
}
