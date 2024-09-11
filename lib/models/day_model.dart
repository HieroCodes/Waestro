import 'package:waestro_mobile/models/hour_model.dart';

class Day {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final int moonIllumination;
  final List<Hour> hours;

  Day({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.moonIllumination,
    required this.hours,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    var hoursFromJson = json['hour'] as List;
    List<Hour> hourList = hoursFromJson.map((i) => Hour.fromJson(i)).toList();

    return Day(
      date: DateTime.parse(json['date']),
      maxTemp: json['day']['maxtemp_c'],
      minTemp: json['day']['mintemp_c'],
      condition: json['day']['condition']['text'],
      moonIllumination: json['astro']['moon_illumination'],
      hours: hourList,
    );
  }
}
