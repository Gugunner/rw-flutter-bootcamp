import 'package:flutter/material.dart';
import 'package:pokedex/auth_user_feature/ui/login_screen.dart';
import 'package:pokedex/general_app_feature/data/fake_repository.dart';
import 'package:pokedex/general_app_feature/ui/widgets/search_bar.dart';
import 'package:pokedex/general_app_feature/utils/pokemon_search.dart';
import 'package:pokedex/pokemon_detail_feature/domain/pokemon_model.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/pokemon_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PokemonModel> pokemons = [];
  List<PokemonModel> originalPokemons = [];
  final fakeRepository = FakePokemonRepository();
  bool isSignedIn = false;
  late ScrollController scrollController;
  late TextEditingController textEditingController;
  final toolbarHeight = 0.0;
  final expandedHeight = 60.0;

  @override
  void initState() {
    super.initState();
    pokemons = fakeRepository.getFakePokedex();
    originalPokemons = pokemons;
    scrollController = ScrollController()..addListener(() => setState(() {}));
    textEditingController = TextEditingController()
      ..addListener(searchPokemons);
  }

  @override
  void dispose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  bool get showSearch {
    if (scrollController.hasClients) {
      return scrollController.offset <= expandedHeight * 0.2;
    }
    return true;
  }

  void _login() {
    setState(() {
      isSignedIn = true;
    });
  }

  void searchPokemons() {
    final text = textEditingController.text;
    if (text.isEmpty) {
      cleanSearch();
      return;
    }
    final pokemonsByName = PokemonSearch.searchBy(SearchBy.name,
        pokemons: originalPokemons, value: text);
    final pokemonsByType = PokemonSearch.searchBy(SearchBy.type,
        pokemons: originalPokemons, value: text);

    if (pokemonsByName.isNotEmpty || pokemonsByType.isNotEmpty) {
      setState(() {
        pokemons =
            <PokemonModel>{...pokemonsByName, ...pokemonsByType}.toList();
      });
    } else {
      setState(() {
        pokemons = [];
      });
    }
  }

  void cleanSearch() {
    setState(() {
      pokemons = originalPokemons;
      textEditingController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: isSignedIn
          ? AppBar(
              title: const Text("Pokedex Sample"),
              backgroundColor: Colors.orange,
            )
          : null,
      body: isSignedIn
          ? CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              slivers: <Widget>[
                SearchBar(
                  showSearch: showSearch,
                  toolbarHeight: toolbarHeight,
                  expandedHeight: expandedHeight,
                  // search: searchPokemons,
                  controller: textEditingController,
                  cleanSearch: cleanSearch,
                ),
                if (pokemons.isEmpty)
                  SliverFillViewport(
                      delegate: SliverChildBuilderDelegate((context, number) {
                    return Container(
                      width: screenWidth,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.catching_pokemon_outlined),
                          Text('No pokemon found'),
                        ],
                      )),
                    );
                  })),
                if (pokemons.isNotEmpty)
                  SliverGrid.count(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    children: <Widget>[
                      ...pokemons.map((p) => PokemonCard(pokemon: p))
                    ],
                  )
              ],
            )
          : Login(
              login: _login,
            ),
    );
  }
}
