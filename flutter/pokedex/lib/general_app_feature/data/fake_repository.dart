import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';

class FakePokemonRepository {
  List<PokemonModel> getFakePokedex() {
    return pokedexSample().map((p) => PokemonModel.fromJson(p)).toList();
  }

  List<Map<String, dynamic>> pokedexSample() => ([
        {
          'num': '001',
          'name': 'Bulbasaur',
          'img': 'assets/pokemon_images/001.png',
          'type': [
            'Grass',
            'Poison',
          ],
          'locations': [
            [20, 30]
          ],
          'entry':
              'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.'
        },
        {
          'num': '004',
          'name': 'Charmander',
          'img': 'assets/pokemon_images/004.png',
          'type': [
            'Fire',
          ],
          'locations': [
            [60, 145]
          ],
          'entry':
              'It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.'
        },
        {
          'num': '007',
          'name': 'Squirtle',
          'img': 'assets/pokemon_images/007.png',
          'type': [
            'Water',
          ],
          'locations': [
            [121, 220]
          ],
          'entry':
              'When it retracts its long neck into its shell, it squirts out water with vigorous force.'
        },
        {
          'num': '027',
          'name': 'Sandshrew',
          'img': 'assets/pokemon_images/027.png',
          'type': [
            'Ground',
          ],
          'locations': [
            [87, 84]
          ],
          'entry':
              'It loves to bathe in the grit of dry, sandy areas. By sand bathing, the Pokémon rids itself of dirt and moisture clinging to its body.'
        },
        {
          'num': '104',
          'name': 'Cubone',
          'img': 'assets/pokemon_images/104.png',
          'type': [
            'Ground',
          ],
          'locations': [
            [87, 84]
          ],
          'entry':
              'When the memory of its departed mother brings it to tears, its cries echo mournfully within the skull it wears on its head.'
        },
        {
          'num': '151',
          'name': 'Mew',
          'img': 'assets/pokemon_images/151.png',
          'type': [
            'Psychic',
          ],
          'locations': [
            [280, 320]
          ],
          'entry':
              'When viewed through a microscope, this Pokémon’s short, fine, delicate hair can be seen.'
        }
      ]);
}
