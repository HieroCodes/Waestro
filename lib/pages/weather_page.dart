import 'package:flutter/material.dart';
import 'package:waestro_mobile/services/weather_service.dart';
import 'package:waestro_mobile/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  //api key
  final _weatherService = WeatherService("ba77028036d04fc683174830241009");
  Weather? _weather;

  _fetchWeather() async {
    //String cityName = await _weatherService.getcurrentCity();

    try {
      final weather = await _weatherService.getWeather("Paris");
      
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Text(_weather?.cityName ?? "loading")]),
    );
  }
}
