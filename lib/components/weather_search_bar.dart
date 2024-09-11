import 'package:flutter/material.dart';
import 'package:waestro_mobile/pages/waether_result_page.dart';
import 'package:waestro_mobile/services/weather_service.dart';
import 'package:waestro_mobile/models/weather_model.dart'; // Import du modèle Weather

class LocationSearchBar extends StatefulWidget {
  final WeatherService weatherService;

  LocationSearchBar({required this.weatherService});

  @override
  _LocationSearchBarState createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false; // Indicateur de chargement

  // Fonction pour naviguer vers la page des résultats météo avec l'objet Weather
  void _navigateToWeatherResults(Weather weather) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherResultPage(weather: weather),
      ),
    );
  }

  // Fonction pour récupérer les données météo à partir de la ville entrée
  Future<void> _fetchWeather() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String cityName = _textController.text;
        Weather weather = await widget.weatherService.getWeather(cityName); // Appel à WeatherService

        setState(() {
          _isLoading = false;
        });

        _navigateToWeatherResults(weather); // Naviguer avec l'objet Weather
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la récupération des données météo')),
        );
      }
    }
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
              onPressed: _isLoading ? null : _fetchWeather, // Désactivez le bouton lors du chargement
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Rechercher'),
            ),
          ],
        ),
      ),
    );
  }
}
