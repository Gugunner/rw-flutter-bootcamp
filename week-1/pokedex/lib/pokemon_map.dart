import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location({
    Key? key,
    required this.locations,
  }) : super(key: key);

  final List<List<double>> locations;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Container(
              width: 280,
              height: 320,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/pokemon_map.png',
                      ),
                      fit: BoxFit.fill)),
            ),
            ...locations.map((location) => Capture(location: location)),
          ],
        ),
      ),
    );
  }
}

class Capture extends StatelessWidget {
  const Capture({
    Key? key,
    required this.location,
  }) : super(key: key);

  final List<double> location;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: location[0],
        top: location[1],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
            border: Border.all(width: 2.0, color: Colors.red),
          ),
          child: Image.asset(
            'assets/pokeball.png',
            width: 30,
            height: 30,
          ),
        ));
  }
}
