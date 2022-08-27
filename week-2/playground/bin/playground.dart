import 'dart:math';

void main(List<String> arguments) {
  quadraticRealEquation(a: 5, b: 6, c: 1);
  firstPythagoreanIdentity(degrees: 45);
  tellMeAStory();
}

///#### Calculates a quadratic equation of real numbers only.
///
///Assign an [a] of value greater than 0 to avoid any infinity values (NaN).
///
///[b] squared must be greater than 4 times [a] times [b] as this function
///does not evaluate complex numbers.
///
///For example...
///```
///quadraticRealEquation(a: 5, b: 6, c: 1) will print
///'The first root of the equation is -0.2 and its integer form is 0'
///'The second root of the equation is -1.0 and its integer form is -1'
///'The biggest root has the value equal to -0.2'
///```
///*If [a] is 0, the function exits and a message is printed.*
///```
///quadraticRealEquation(a: 0, b: 6, c: 1) will print
///'a must be > than 0'
///```
///
///*If [b]^2 is smaller than 4*([a]*[c]), the function exits and a message is printed.*
///```
///quadraticRealEquation(a: 5, b: 1, c: 3) will print
///'b^2 must be > than 4ac to prevent complex values'
///```
void quadraticRealEquation({
  required num a,
  required num b,
  required num c,
}) {
  //Exits the function if a is not greater than 0 and alerts the user
  if (a <= 0) {
    print('a must be > than 0');
    return;
  }
  //Stores if final value is going to calculate complex numbers
  final isComplex = (pow(b, 2) - 4 * (a * c)) < 0;
  //Exits the function if complex numbers would be calculated
  if (isComplex) {
    print('b^2 must be > than 4ac to prevent complex values');
    return;
  }
  //Stores first root of quadratic equation
  final double x1 = (-b + sqrt((b * b - 4 * (a * c)))) / (2 * a);
  //Stores second root of quadratic equation
  final double x2 = (-b - sqrt((b * b - 4 * (a * c)))) / (2 * a);
  //Compares and stores bigger root
  final double bigX = x1 > x2 ? x1 : x2;
  print(
      'The first root of the equation is $x1 and its integer form is ${x1.toInt()}');
  print(
      'The second root of the equation is $x2 and its integer form is ${x2.toInt()}');
  print('The biggest root has the value equal to $bigX');
}

///### Prints the first pythagorean identity using [sine] and [cosine].
///
///Transforms the [degrees] into [radians] and then applies the
///pythagorean theorem where a^2+b^2=c^2 where a is [sine], b is [cosine],
///it prints the result.
///
///For example...
///```
///firstPythagoreanIdentity(45) will print
///'The value of the expression sin^2(0.7853981633974483) + cos^2($0.7853981633974483) is 1'
///```
///
///As a bonus it prints the f(x) result if the equation was a^2+b^2+a.
///```
///'The value of the expression sin^2(0.7853981633974483) + cos^2(0.7853981633974483) + sin(0.7853981633974483) is 1.7071067811865475 and its run type value is double'
///```
void firstPythagoreanIdentity({required int degrees}) {
  //Stores the converted value of [degrees]
  final radians = (degrees * pi) / 180;
  //Stores the result of the sine([radians])
  final sineValue = sin(radians);
  //Stores the result of the cosine([radians])
  final cosValue = cos(radians);
  //Stores the result of sine^2 + cosine^2
  var result = pow(sineValue, 2) + pow(cosValue, 2);
  print(
      'The value of the expression sin^2($radians) + cos^2($radians) is $result and its run type value is {runtype value of result}');
  result += sineValue;
  print(
      'The value of the expression sin^2($radians) + cos^2($radians) + sin($radians) is $result and its run type value is ${result.runtimeType}');
}

///Creates an exciting static story that interpolates and concatenates 7 variables
///as [String] and finally prints a non veridic [newStory].
void tellMeAStory() {
  ///The inputs that are interpolated in the story
  const num inputOne = 8.9;
  const num inputTwo = 10;
  const String inputThree = 'earthquake';
  const String inputFour = 'nemesis';
  const String inputFive = 'mattered';
  const bool inputSix = true;
  final dynamic inputSeven = <String, dynamic>{
    'assistInputOne': 'fear',
    'assistInputTwo': 0,
  };
  //Introduction to the story, who is it about
  var newStory =
      'Once upon a time when it most $inputFive a city was about to be hit hard by an incredible calamity.';
  //What is the problem of the story
  newStory +=
      ' An $inputThree was imminent and the people living in the peaceful city were not aware of it, how could they know'
      ' that the magnitude of this $inputThree would instill ${inputSeven["assistInputOne"]} in the hearts of each and everyone.\n';
  //What impact will the story have in the protagonist....the city
  newStory =
      '${newStory}The magnitude of this event was to be remembered for it\'s number, an astounding $inputOne $inputThree was about to '
      'hit hard, the event would become the $inputFour of all the citizens because it was $inputTwo times greater than any $inputThree before.\n';

  ///Climax of the story
  newStory +=
      'Nevertheless no one had any idea, the day came and the $inputThree hit hard, people where struggling to find safety while the trembling was the most horrific, '
      'people could not believe that in just a matter of $inputTwo minutes their beloved city was irrecognizible.\n';

  ///The end
  newStory +=
      'This is a ${!inputSix} story, and has ${inputSeven["assistInputTwo"]} credibility, so please stop reading and grade me with an amazing score! \u{1F61B}';
  print(newStory.split(' ').length);
  print(newStory);
}
