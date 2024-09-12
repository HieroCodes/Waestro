import 'package:waestro_mobile/models/hour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importez ce package pour afficher les SVG dans Flutter

class Day {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String icon;
  final String moonPhase;
  //final String moonIllumination;
  //final double cloudCover;
  final List<Hour> hours;

  Day({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.icon,
    required this.moonPhase,
    //required this.moonIllumination,
    //required this.cloudCover,
    required this.hours,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    var hoursFromJson = json['hour'] as List;
    List<Hour> hourList = hoursFromJson.map((i) => Hour.fromJson(i)).toList();

    String iconUrl = json['day']['condition']['icon'];
    if (iconUrl.startsWith('//')) {
      iconUrl = 'https:' + iconUrl;
    }

    return Day(
      date: DateTime.parse(json['date']),
      maxTemp: json['day']['maxtemp_c'],
      minTemp: json['day']['mintemp_c'],
      icon: iconUrl,
      moonPhase: json['astro']['moon_phase'],
      //moonIllumination: json['astro']['moon_illumination'] ?? 'N/A',
      //cloudCover: json['day']['daily_chance_of_rain']?.toDouble() ?? 0.0,
      hours: hourList,
    );
  }

  // Méthode pour obtenir le chemin de l'image SVG de la phase lunaire
  String getMoonPhaseImagePath() {
    switch (moonPhase.toLowerCase()) {
      case 'new moon':
        return 'lib/assets/images/moon_phases/new_moon.svg';
      case 'waxing crescent':
        return 'lib/assets/images/moon_phases/waxing_crescent.svg';
      case 'first quarter':
        return 'lib/assets/images/moon_phases/first_quarter.svg';
      case 'waxing gibbous':
        return 'lib/assets/images/moon_phases/waxing_gibbous.svg';
      case 'full moon':
        return 'lib/assets/images/moon_phases/full_moon.svg';
      case 'waning gibbous':
        return 'lib/assets/images/moon_phases/waning_gibbous.svg';
      case 'third quarter':
        return 'lib/assets/images/moon_phases/third_quarter.svg';
      case 'waning crescent':
        return 'lib/assets/images/moon_phases/waning_crescent.svg';
      default:
        return 'lib/assets/images/moon_phases/full_moon.svg';
    }
  }
}
