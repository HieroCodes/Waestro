import 'dart:convert';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  static const BASE_URL = 'http://api.weatherapi.com/v1/forecast.json?key=';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    //final url = '$apiKey&q=$cityName&days=6';
    final url = '$BASE_URL$apiKey&q=$cityName&days=6';
    final response = await http.get(Uri.parse(url));
    //final response = await http.get(Uri.parse('$BASE_URL$url'));

    if (response.statusCode == 200) {
      print(response.body);
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getcurrentCity() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifie si les services de localisation sont activés.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Le service de localisation est désactivé.');
    }

    // Vérifie les permissions de localisation.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Les autorisations de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Les autorisations de localisation sont refusées de manière permanente.');
    }

    // Obtenir la position actuelle avec les nouvelles options de configuration.
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // Précision élevée
        distanceFilter: 100, // Filtre de distance pour limiter les mises à jour
      ),
    );
    String coords = '${position.latitude}, ${position.longitude}';

    return coords;
  }
}