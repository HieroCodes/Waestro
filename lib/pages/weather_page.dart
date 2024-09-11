import 'package:flutter/material.dart';
import 'package:waestro_mobile/services/weather_service.dart';
import 'package:waestro_mobile/models/weather_model.dart';
import 'package:waestro_mobile/components/weather_search_bar.dart';

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
      print("Error fetching weather: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Ce container enveloppe tout le contenu du Scaffold et applique le fond en dégradé
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(-1, 1),
            colors: <Color>[
              Color(0xFF101010),
              Color.fromARGB(255, 38, 40, 55),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LocationSearchBar(weatherService: _weatherService),
              if (_weather != null)
                Column(
                  children: <Widget>[
                    Text(
                      '${_weather!.cityName}',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '${_weather!.temp}°C',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Image.network('https:${_weather!.icon}'),
                    Text(
                      '${_weather!.date}',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              if (_weather == null) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
