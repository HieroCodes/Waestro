class Hour {
  final DateTime time;
  final double temp;
  final double visibility;
  final double feelslike;
  final double precipitation;
  final double windSpeed;
  final String condition;
  final int humidity;
  final int cloud;
  final bool isDay;

  Hour({
    required this.time,
    required this.temp,
    required this.condition,
    required this.visibility,
    required this.feelslike,
    required this.precipitation,
    required this.windSpeed,
    required this.humidity,
    required this.cloud,
    required this.isDay,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: DateTime.parse(json['time']),
      temp: json['temp_c'],
      condition: json['condition']['text'],
      visibility: json['vis_km'],
      feelslike: json['feelslike_c'],
      precipitation: json['precip_mm'],
      windSpeed: json['wind_kph'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      isDay: json['is_day'] == 1,
    );
  }
}
