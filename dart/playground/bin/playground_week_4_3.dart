import 'playground_week_4_2.dart';

void main() {
  final bikeInstance = Bike.instance;
  final scooterInstance = Bike.instance;
  final carInstance = Car.instance;
  //Bike instance
  bikeInstance.start();
  bikeInstance.accelerate();
  bikeInstance.brake();
  bikeInstance.stop();
  //Scooter instance
  scooterInstance.start();
  scooterInstance.accelerate();
  scooterInstance.brake();
  scooterInstance.stop();
  //Car instance
  carInstance.start();
  carInstance.accelerate();
  carInstance.brake();
  carInstance.stop();

  print('ray  wenderlich  '.allCapitals);
  final instance = Assignment2.instance;
  final pokemons = Pokemon.fromJsonList(instance.pokemonsMap);
  pokemons.sort();
  print(pokemons);
}

abstract class Vehicle {
  void start();
  void stop();
  void accelerate();
  void brake();
}

class Bike extends Vehicle {
  static final instance = Bike();

  @override
  void start() {
    print('Bike is starting');
  }

  @override
  void accelerate() {
    print('Bike is accelerating');
  }

  @override
  void brake() {
    print('Bike is braking');
  }

  @override
  void stop() {
    print('Bike is stopping');
  }
}

class Scooter extends Vehicle {
  static final instance = Scooter();
  @override
  void start() {
    print('Scooter is starting');
  }

  @override
  void accelerate() {
    print('Scooter is accelerating');
  }

  @override
  void brake() {
    print('Scooter is braking');
  }

  @override
  void stop() {
    print('Scooter is stopping');
  }
}

class Car extends Vehicle {
  static final instance = Car();
  @override
  void start() {
    print('Car is starting');
  }

  @override
  void accelerate() {
    print('Car is accelerating');
  }

  @override
  void brake() {
    print('Car is braking');
  }

  @override
  void stop() {
    print('Car is stopping');
  }
}

extension on String {
  String get allCapitals {
    final splitString = trim().split(RegExp(r'\s+'));
    return splitString.map((s) => s.capitalOne.trim()).join(' ');
  }

  String get capitalOne => substring(0, 1).toUpperCase() + substring(1);
}

class Pokemon implements Comparable {
  Pokemon({
    required this.type,
    required this.speed,
    required this.name,
  });

  final String type;
  final int speed;
  final String name;

  @override
  int compareTo(other) {
    return speed - (other as Pokemon).speed;
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        type: json['type'] as String,
        speed: json['speed'] as int,
        name: json['name']);
  }

  static List<Pokemon> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Pokemon.fromJson(json)).toList();
  }

  @override
  String toString() {
    return '\n{\n'
        ' "name": "$name",\n'
        ' "type": "$type"\n'
        ' "speed": "$speed",\n'
        '}';
  }
}
