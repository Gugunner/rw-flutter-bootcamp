void main() {
  final instance = Assignmment1.instance;
  instance.printingName(
      name: 'Raul', surname: 'Alonzo', isSurnameAtStart: true);
  instance.printingName(
      name: 'Raul', surname: 'Alonzo', isSurnameAtStart: false);
  instance.printingName(name: 'Raul', surname: 'Alonzo');
  instance.printingName(name: 'Raul', isSurnameAtStart: true);
  instance.printingName(name: 'Raul');
  instance.printingName(name: 'Raul', isSurnameAtStart: false);
}

///In programming there is always the risk of having a null value in a variable, while there are many ways to address this issue depending
///on the programming language Dart uses a specific type for Nullable and Non Nullable types.
///All variable types descend from the Object or Object? type and there is an Object Nullable type and Object Non Nullable type, so any variable can be
///handled as one or the other.
///
///A Nullable type is a variable that can have no value this means that there is no value in memory assigned to the
///variable which normally happens when a requirement is not met, whether is a process, a request or some data missing assigning a nullable type
///is the way for Dart to specify that a value was not assigned, to declare a Nullable type follow the Type with a question mark like this 'Object?'.
///
///Different from the Nullable type is the Non Nullable type which always has a value, the most important difference is that the variable must alway be initialized with
///a value of the correct type and when used inside the program will always have a value.
///
///There is a risk when using Nullable types so that is why Dart has null aware operators, this operators prevent the program at compilation and runtime
///from handling a variable with an absence of value. Depending on the situation there are several null aware operatos that can be used, while most
///will help prevent throwing an Unhandled Exception such as the following:
///```
///Unhandled exception:
///Null check operator used on a null value
///#0main (file:///Users/Gugunner-Oryx-Pro/Documents/Raywenderlich/Bootcamp/rw-flutter-bootcamp/dart/playground/bin/playground_week_4_1.dart:19:13)
///#1      _delayEntrypointInvocation.<anonymous closure> (dart:isolate-patch/isolate_patch.dart:297:19)
///#2      _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:192:12)
///```
///The following is a list of Nullable aware operators that can be used.
///+ If-null operator (??) - Use when checking for default value => ```text ?? 'empty'```
///+ Null-aware assignment operator (??=) - Use when assigning a default value ```text ??= 'empty'```
///+ Null-aware access operator (?.) - Use to access a possible null value ```text?.isEmpty```
///+ Null-aware method invocation operator (?.) - Use to invoke an instance method ``newList?.split(',')
///+ Null assertion operator (!) - Use cautiously only when sure the value exists ```nonNullable!.call()
///+ Null-aware cascade operator (?..) - Use when accesing more than one property or method ```pokemon..attack()..heal()```
///+ Null-aware index operator (?[]) - Use when accesing a nullable list specific index ```cars?[index]```
///+ Null-aware spread operator (...?) - Use when spreading a nullable list ```newList = [...?nullableList, ...nonNullableList]```
///
///Using null aware operators and null safety is crucial to deal with Dart, for more information check the following (https://dart.dev/null-safety/understanding-null-safety)
///
///
class Assignmment1 {
  static final instance = Assignmment1();

  void printingName({
    required String name,
    String? surname,
    bool? isSurnameAtStart,
  }) {
    final nameToPrint = surname?.isNotEmpty ?? false
        ? isSurnameAtStart ?? false
            ? '$surname $name'
            : '$name $surname'
        : name;

    print(nameToPrint);
  }
}
