import 'package:waestro_mobile/models/day_model.dart';

class Weather {
  final String cityName;
  final double temp;
  final double feelslike;
  final DateTime date;
  final String icon;
  final bool isDay;
  final bool isMoon;
  final List<Day> days;
  final String condition;

  Weather({
    required this.cityName,
    required this.temp,
    required this.feelslike,
    required this.date,
    required this.icon,
    required this.isDay,
    required this.isMoon,
    required this.days,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      temp: json['current']['temp_c'],
      feelslike: json['current']['feelslike_c'],
      date: DateTime.parse(json['location']['localtime']),
      icon: json['current']['condition']['icon'],
      isDay: json['current']['is_day'] == 1,
      isMoon: json['current']['is_day'] == 1,
      days: (json['forecast']['forecastday'] as List)
          .map((i) => Day.fromJson(i))
          .toList(),
      condition: json['current']['condition']['text'],
    );
  }

  String getIsDayBackground() {
    return isDay
        ? 'lib/assets/images/backgrounds/day.png'
        : 'lib/assets/images/backgrounds/night.png';
  }

  String getMoonBackground() {
    return isMoon
        ? 'lib/assets/images/forecast_hourly/full.svg'
        : 'lib/assets/images/forecast_hourly/half.svg';
  }
}
