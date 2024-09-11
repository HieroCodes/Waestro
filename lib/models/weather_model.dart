import 'package:waestro_mobile/models/day_model.dart';

class Weather {
  final String cityName;
  final double temp;
  final double feelslike;
  final DateTime date;
  final String icon;
  final List<Day> days;

  Weather({
    required this.cityName,
    required this.temp,
    required this.feelslike,
    required this.date,
    required this.icon,
    required this.days,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      temp: json['current']['temp_c'],
      feelslike: json['current']['feelslike_c'],
      date: DateTime.parse(json['location']['localtime']),
      icon: json['current']['condition']['icon'],
      days: (json['forecast']['forecastday'] as List)
          .map((i) => Day.fromJson(i))
          .toList(),
    );
  }
}
