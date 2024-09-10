import 'package:flutter/material.dart';
import 'package:waestro_mobile/services/weather_service.dart';
import 'package:waestro_mobile/pages/waether_result_page.dart'; // Import de la nouvelle page

class LocationSearchBar extends StatefulWidget {
  final WeatherService weatherService;

  LocationSearchBar({required this.weatherService});

  @override
  _LocationSearchBarState createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  // Fonction pour naviguer vers la page des résultats météo
  void _navigateToWeatherResults(String cityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherResultPage(
          cityName: cityName,
          weatherService: widget.weatherService, // Passez WeatherService
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Entrez une ville',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ ne peut pas être vide';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String cityName = _textController.text;
                  _navigateToWeatherResults(cityName); // Naviguer vers la nouvelle page
                }
              },
              child: Text('Rechercher'),
            ),
          ],
        ),
      ),
    );
  }
}