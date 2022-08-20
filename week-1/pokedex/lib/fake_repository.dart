import 'package:pokedex/pokemon_model.dart';

class FakePokemonRepository {
  List<PokemonModel> getFakePokedex() {
    return pokedexSample().map((p) => PokemonModel.fromJson(p)).toList();
  }

  List<Map<String, dynamic>> pokedexSample() => ([
        {
          "num": "001",
          "name": "Bulbasaur",
          "img": "assets/pokemon_images/001.png",
          "type": [
            "Grass",
            "Poison",
          ],
          'location': [20, 30],
        },
        {
          "num": "004",
          "name": "Charmander",
          "img": "assets/pokemon_images/004.png",
          "type": [
            "Fire",
          ],
          'location': [20, 30],
        },
        {
          "num": "007",
          "name": "Squirtle",
          "img": "assets/pokemon_images/007.png",
          "type": [
            "Water",
          ],
          'location': [20, 30],
        },
        {
          "num": "027",
          "name": "Sandshrew",
          "img": "assets/pokemon_images/027.png",
          "type": [
            "Ground",
          ],
          'location': [20, 30],
        },
        {
          "num": "104",
          "name": "Cubone",
          "img": "assets/pokemon_images/104.png",
          "type": [
            "Ground",
          ],
          'location': [20, 30],
        },
        {
          "num": "151",
          "name": "Mew",
          "img": "assets/pokemon_images/151.png",
          "type": [
            "Psychic",
          ],
          'location': [20, 30],
        }
      ]);
}
