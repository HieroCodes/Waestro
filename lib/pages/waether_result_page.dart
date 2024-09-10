import 'package:flutter/material.dart';
import 'package:waestro_mobile/services/weather_service.dart';
import 'package:waestro_mobile/models/weather_model.dart';

class WeatherResultPage extends StatelessWidget {
  final String cityName;
  final WeatherService weatherService;

  WeatherResultPage({required this.cityName, required this.weatherService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo pour $cityName'),
      ),
      body: FutureBuilder<Weather>(
        future: weatherService.getWeather(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;
            return Center(
              child: Text(
                'Température actuelle: test °C',
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return Center(child: Text('Aucune donnée disponible'));
          }
        },
      ),
    );
  }
}