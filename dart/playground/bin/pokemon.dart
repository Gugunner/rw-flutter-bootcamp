import 'dart:math';

enum PokemonType { fire, grass, water, undefined }

///A generic pokemon can be declared with [hp] 10 by default.
///
///The pokemon can battle it out with any other pokemon but tha damage it can deal
///and the damage it receives is based on a list of [PokemonType], [weak] is all the types
///that do 2X damage to this and [strong] is all the types that do 0.5X damage to this.
///
///For example a [Pokemon] with [type] fire [attack] a [Pokemon] with [type] grass, the fire
///[Pokemon] does 2X damage to the grass [Pokemon]. So if the grass [Pokemon] has 6 hp and the [reduceHpBy]
///is 1 the grass [Pokemon] now has 4 hp left.
///
///If you want to see many pokemon duke it out just call the static method [freeForAll] and pass a list of [Pokemon].
///```
///final battlers = <Pokemon>[bulbasaur, charmander, squirtle];
///Pokemon.freeForAll(battlers);
///'🏆Squirtle has won the battle with remaining hp 3.5.'
///```
class Pokemon {
  Pokemon({
    required this.name,
    this.hp = 10,
    required this.type,
    required this.weak,
    required this.strong,
  });

  ///[Pokemon] with fire [type] that has specific [weak] and [strong] [PokemonType]
  factory Pokemon.fire({
    required String name,
  }) {
    return Pokemon(
        name: name,
        type: PokemonType.fire,
        weak: [PokemonType.water],
        strong: [PokemonType.grass]);
  }

  ///[Pokemon] with water [type] that has specific [weak] and [strong] [PokemonType]
  factory Pokemon.water({
    required String name,
  }) {
    return Pokemon(
        name: name,
        type: PokemonType.water,
        weak: [PokemonType.grass],
        strong: [PokemonType.fire]);
  }

  ///[Pokemon] with grass [type] that has specific [weak] and [strong] [PokemonType]
  factory Pokemon.grass({
    required String name,
  }) {
    return Pokemon(
        name: name,
        type: PokemonType.grass,
        weak: [PokemonType.fire],
        strong: [PokemonType.water]);
  }

  ///Identifier of the pokemon
  final String name;

  ///Health points of the pokemon, start at 10 HP
  double hp;
  final PokemonType type;

  ///Defines to which [type] this is weak against when defending
  final List<PokemonType> weak;

  ///Defines to which [type] this is strong when defending
  final List<PokemonType> strong;

  ///Call the method to restore all pokemon health up to [healBy]
  static pokemonCenter(List<Pokemon> pokemons, [double healBy = 10]) {
    for (var p in pokemons) {
      p.hp = healBy;
    }
  }

  ///Call for a big fight where there are no rules.
  ///
  ///A random attacker and random defender is selected from the battlers each round,
  ///if the attacker has more than 0 hp the attacker can try to hit the defender.
  ///If the defender is already knocked out, then the attacker just roars with fury.
  ///
  ///The battle continues until only one survivor is left and it is declared the winner!
  static freeForAll(List<Pokemon> battlers) {
    int attackerIndex = -1;
    int defenderIndex = -1;
    do {
      while (attackerIndex == defenderIndex) {
        attackerIndex = Random().nextInt(battlers.length);
        defenderIndex = Random().nextInt(battlers.length);
      }
      final attacker = battlers[attackerIndex];
      final defender = battlers[defenderIndex];

      ///Evaluates if attacker is not knocked out.
      if (attacker.hp > 0) {
        attacker.attack(defender);
      }
      //Resets index so a new attacker and defender can be chosen
      attackerIndex = -1;
      defenderIndex = -1;
    } while (battlers.where((b) => b.hp > 0).toList().length > 1);
    final winner = battlers.firstWhere((b) => b.hp > 0);
    print('\n*****************************');
    print('A VICTOR EMERGES!\n');
    print(
        '\u{1F3C6}${winner.name} has won the battle with remaining hp ${winner.hp}.\n');
  }

  ///This attacks the [pokemon] who is treated as the defender.
  void attack(Pokemon pokemon) {
    //Attacks only happen if the defender pokemon is not knocked out.
    if (pokemon.hp > 0) {
      pokemon.hp -= damage(pokemon: pokemon);
      //Prevents negative hp for the pokemon when 2X factor is applied
      if (pokemon.hp < 0) {
        pokemon.hp = 0;
      }
      print('$name($hp) attacks ${pokemon.name}(${pokemon.hp})');
    } else {
      print('$name roars with fury!');
    }
  }

  ///Checks if the defender [pokemon] type is weak or strong against this.
  ///
  ///By default the damage dealt always [reduceHpBy] 1 but it can be modified
  ///if [Pokemon] are higher levels.
  ///
  ///If defending [Pokemon] is [weak] against this [type] the factor is 2X.
  ///If defending [Pokemon] is [strong] against this [type] the factor is 0.5X.
  ///If it is neither [weak] nor [strong] then the factor is 1X.
  ///
  ///For example if bulbasaur who is a grass [type] is attacked by charmander a fire [type],
  ///bulbasaur will receive 2X factor damage if [reduceHpBy] is 1 the bulbasaur will be damaged by 2.0.
  ///```
  ///charmander.damage(pokemon: bulbasaur) => 2.0
  ///```
  double damage({required Pokemon pokemon, double reduceHpBy = 1}) {
    final isWeak = pokemon.weak.contains(type);
    if (isWeak) {
      return reduceHpBy * 2;
    }
    final isStrong = pokemon.strong.contains(type);
    if (isStrong) {
      return reduceHpBy * 0.5;
    }
    return reduceHpBy * 1;
  }
}
