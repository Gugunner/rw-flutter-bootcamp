import 'pokemon.dart';

void main() {
  final bulbasaur = Pokemon.grass(name: 'Bulbasaur');
  final charmander = Pokemon.fire(name: 'Charmander');
  final squirtle = Pokemon.water(name: 'Squirtle');
  final battlers = <Pokemon>[bulbasaur, charmander, squirtle];
  Pokemon.freeForAll(battlers);
  Pokemon.pokemonCenter(battlers);
  for (var b in battlers) {
    print('${b.name} healed up to ${b.hp} HP');
  }
}
