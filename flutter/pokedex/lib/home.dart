import 'package:flutter/material.dart';
import 'package:pokedex/auth_user_feature/ui/login_screen.dart';
import 'package:pokedex/general_app_feature/ui/widgets/search_bar.dart';
import 'package:pokedex/general_app_feature/utils/build_context.dart';
import 'package:pokedex/pokemon_detail_feature/domain/provider/pokemon_provider.dart';
import 'package:pokedex/pokemon_detail_feature/ui/widgets/pokemon_card.dart';
import 'package:pokedex/pokemon_capture_feature/ui/captured_pokemon_screen.dart';
import 'package:pokedex/pokemon_capture_feature/provider/pokemon_capture_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSignedIn = false;
  late ScrollController scrollController;
  late TextEditingController textEditingController;
  final toolbarHeight = 0.0;
  final expandedHeight = 60.0;
  late PokemonCaptureProvider captureProvider;
  late PokemonProvider pokemonProvider;
  late Future _future;
  bool loading = false;
  bool search = false;

  @override
  void initState() {
    super.initState();
    pokemonProvider = context.read<PokemonProvider>();

    ///Assign the future to a variable so it is wrapped in a lazy call
    ///doing this avoids the [FutureBuilder] from calling the function
    ///each time the [StatefulWidget] rebuilds.
    _future = pokemonProvider.retrieveInitialPokemons();
    scrollController = ScrollController()..addListener(loadPokemons);
    textEditingController = TextEditingController()..addListener(updateSearch);
  }

  @override
  void dispose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  ///Simple call to signIn the user and change widgets
  void _login() {
    setState(() {
      isSignedIn = true;
    });
  }

  ///Each time the user uses the search bar to lookup some
  ///specific pokemons, the [pokemonListType] checks if the user
  ///is already in search mode or needs to enter it.
  void updateSearch() {
    final text = textEditingController.text;
    pokemonProvider.searchTerm = text;
    if (pokemonProvider.pokemonListType != PokemonListType.search) {
      pokemonProvider.pokemonListType = PokemonListType.search;
    }
    pokemonProvider.updateCurrentPokemons();
  }

  ///If the scroll position is above 80% of the
  ///maximum scroll and the app is not loading any new pokemons
  ///the app tries to update the pokemons in the app, this is the
  ///implementation of the infinite scrolling.
  void loadPokemons() async {
    if (scrollController.position.pixels >
            scrollController.position.maxScrollExtent * 0.80 &&
        !loading) {
      loading = true;
      await pokemonProvider.retrievePokemonsByPosition();
      loading = false;
      pokemonProvider.updateCurrentPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    captureProvider = context.watch<PokemonCaptureProvider>();
    pokemonProvider = context.watch<PokemonProvider>();
    return Scaffold(
      appBar: !isSignedIn
          ? AppBar(
              title: Row(children: [
                const Expanded(child: Text('Pokedex Sample')),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CapturedPokemonScreen(
                        captureProvider: captureProvider,
                      );
                    }));
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.catching_pokemon_rounded,
                        // ignore: todo
                        //TODO: Add change to color when a pokemon is added to capture list
                        color: captureProvider.trainerStatus.color,
                        size: 35,
                      ),
                      Text(
                        '${captureProvider.trainerStatus.status} trainer',
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                )
              ]),
              backgroundColor: Colors.orange,
            )
          : null,
      body: !isSignedIn
          ? FutureBuilder(
              future: _future,
              builder: (context2, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (pokemonProvider.paginatedPokemons.isNotEmpty) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          slivers: <Widget>[
                            SearchBar(
                              toolbarHeight: toolbarHeight,
                              expandedHeight: expandedHeight,
                              controller: textEditingController,
                            ),
                            if (pokemonProvider.currentPokemons.isEmpty)
                              const NoPokemonFound(),
                            if (pokemonProvider.currentPokemons.isNotEmpty)
                              const PokemonsInView(),
                            if (pokemonProvider.errorLoading)
                              const PokemonsNotLoading()
                          ],
                        ),
                        if (loading)
                          Positioned(
                              bottom: 10,
                              left: screenWidth * 0.45,
                              child: const CircularProgressIndicator(
                                color: Colors.orange,
                              ))
                      ],
                    );
                  }
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.white,
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.orange,
                    color: Colors.lightBlue,
                    minHeight: 8,
                  ),
                );
              },
            )
          : Login(
              login: _login,
            ),
    );
  }
}

class NoPokemonFound extends StatelessWidget {
  const NoPokemonFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillViewport(
        delegate: SliverChildBuilderDelegate((context, number) {
      return Container(
        width: context.width,
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
    }));
  }
}

class PokemonsInView extends StatelessWidget {
  const PokemonsInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
    final captureProvider = context.watch<PokemonCaptureProvider>();
    return SliverGrid.count(
      mainAxisSpacing: context.width * 0.024,
      crossAxisSpacing: context.height * 0.015,
      crossAxisCount: 2,
      children: <Widget>[
        ...pokemonProvider.currentPokemons.map((p) => Builder(
            builder: (context2) => PokemonCard(
                  pokemon: p,
                  captureProvider: captureProvider,
                ))),
      ],
    );
  }
}

class PokemonsNotLoading extends StatelessWidget {
  const PokemonsNotLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
    return SliverGrid.count(
      crossAxisCount: 1,
      mainAxisSpacing: 10,
      crossAxisSpacing: 5,
      children: <Widget>[
        SizedBox(
          height: 12,
          child: TextButton(
            onPressed: () {
              pokemonProvider.retrievePokemonsByPosition();
            },
            child:
                const Text('There was an error loading the pokemons, retry?'),
          ),
        )
      ],
    );
  }
}
