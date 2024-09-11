import 'package:flutter/material.dart';
import 'package:waestro_mobile/models/weather_model.dart';

class WeatherResultPage extends StatelessWidget {
  final Weather weather;

  WeatherResultPage({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo pour ${weather.cityName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Température actuelle : ${weather.temp}°C',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Ressenti : ${weather.feelslike}°C',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Prévisions :',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weather.days.length,
                itemBuilder: (context, index) {
                  final day = weather.days[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        '${day.date.toLocal()} - Max: ${day.maxTemp}°C, Min: ${day.minTemp}°C',
                      ),
                      subtitle: Text('Condition : ${day.condition}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
