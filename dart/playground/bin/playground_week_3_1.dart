import 'dart:math';

void main() {
  for (var i = 0; i < 3; i++) {
    print('********************');
    print('Execution - ${i + 1}');
    sarahMenu();
  }
}

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

enum Weather {
  rainy,
  sunny,
  cloudy,
  thunderstorm,
}

///Prints what Sarah likes to eat based on the [WeekDay]
///and the [Weather].
///
///Iterates each [Weekday] value and chooses a weather at random for each day.
///
///Example
///
///When [weekDay] is [tuesday] Sarah always eats pizza.
///```
///sarahMenu()
///'Tuesday is cloudy, so Sarah ate pizza.'
///```
void sarahMenu() {
  final List<WeekDay> weekDays = WeekDay.values;
  final List<Weather> weathers = Weather.values;

  ///Iterates each value of [WeekDay]
  for (var weekDay in weekDays) {
    ///A random generated index from 0 to exclusive [weekDays] length
    final index = Random().nextInt(weathers.length);
    ///The weather chosen by the [index]
    final weather = weathers[index];
    ///A concatenated string that converts the first letter to uppercase
    final weekDayName = weekDay.name[0].toUpperCase() +
        weekDay.name.substring(
          1,
        );
    if (weekDay == WeekDay.tuesday) {
      print('$weekDayName is ${weather.name}, so Sarah ate pizza.');
    } else if (weather == Weather.thunderstorm) {
      print('$weekDayName is ${weather.name}, so Sarah ate tacos.');
    } else if ((weekDay == WeekDay.thursday && weather == Weather.rainy) ||
        ((weekDay == WeekDay.saturday || weekDay == WeekDay.sunday) &&
            weather == Weather.cloudy)) {
      print('$weekDayName is ${weather.name}, so Sarah ate Thai food.');
    } else {
      print('$weekDayName is ${weather.name}, so Sarah made a ham sandwich.');
    }
  }
}
