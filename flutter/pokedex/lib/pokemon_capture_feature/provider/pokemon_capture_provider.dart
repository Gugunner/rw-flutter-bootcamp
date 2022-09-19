import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_detail_feature/domain/model/pokemon_model.dart';
import 'package:pokedex/general_app_feature/utils/string_extension.dart';

enum TrainerStatus {
  starter,
  amateur,
  veteran,
  master,
}

extension DisplayStatus on TrainerStatus {
  Color get color {
    switch (this) {
      case TrainerStatus.starter:
        return Colors.grey;
      case TrainerStatus.amateur:
        return Colors.red;
      case TrainerStatus.veteran:
        return const Color.fromARGB(255, 25, 86, 136);
      case TrainerStatus.master:
        return const Color.fromARGB(255, 122, 29, 139);
    }
  }

  String get status => name.allCapitals;
}

class PokemonCaptureProvider extends ChangeNotifier {
  TrainerStatus trainerStatus = TrainerStatus.starter;

  List<PokemonModel> capturedPokemons = [];

  void updateCapture(PokemonModel pokemon) {
    pokemon.captured = !pokemon.captured;
  }

  void updateCapturedPokemons(List<PokemonModel> pokemons) {
    capturedPokemons = pokemons.where((p) => p.captured).toList();
    updateTrainer(pokemons);
    notifyListeners();
  }

  void updateTrainer(List<PokemonModel> pokemons) {
    final numberOfCaptures = capturedPokemons.length;
    if (numberOfCaptures >= 150) {
      trainerStatus = TrainerStatus.master;
    } else if (numberOfCaptures >= 100) {
      trainerStatus = TrainerStatus.veteran;
    } else if (numberOfCaptures >= 6) {
      trainerStatus = TrainerStatus.amateur;
    } else if (numberOfCaptures >= 0) {
      trainerStatus = TrainerStatus.starter;
    }
  }
}
