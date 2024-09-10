// class Weather {
//   final String cityName;
//   final double tempCelcius;
//   final String date;

//   Weather({
//     required this.cityName,
//     required this.tempCelcius,
//     required this.date,//localtime
//   });

//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(cityName: json['name'], tempCelcius: json['feelslike_c']);
//   }
// }

class Weather {
  final String cityName;

  Weather({
    required this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(cityName: json['location']['name']);
  }
}
