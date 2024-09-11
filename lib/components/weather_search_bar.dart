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
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                'Trouver une localisation', // Texte au-dessus de l'input
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20),
              // Input field
              TextFormField(
                controller: _textController,
                style: TextStyle(color: Colors.white), // Texte blanc
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850], // Couleur de fond du champ
                  prefixIcon: Icon(Icons.search, color: Colors.tealAccent), // Icône de recherche
                  hintText: 'Ville / latitude, longitude', // Placeholder
                  hintStyle: TextStyle(color: Colors.white38), // Couleur du placeholder
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30), // Arrondir les coins
                    borderSide: BorderSide.none, // Pas de bordure
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ ne peut pas être vide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Bouton coller et lancer
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Fond transparent
                    elevation: 0, // Pas d'ombre
                    textStyle: TextStyle(fontSize: 16),
                    foregroundColor: Colors.tealAccent, // Couleur du texte
                  ),
                  onPressed: _isLoading ? null : _fetchWeather,
                  child: Text('Rechercher'),
                ),
              ),
              SizedBox(height: 20),],
        ),
      ),
    );
  }
}
