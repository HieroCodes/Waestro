class Weather {
  final String cityName;
  final double tempCelcius;
  final String date;
  final String icon;

  Weather({
    required this.cityName,
    required this.tempCelcius,
    required this.date,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      tempCelcius: json['current']['feelslike_c'],
      date: json['location']['localtime'],
      icon: json['current']['condition']['icon'],
    );
  }
}
