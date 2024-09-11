import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waestro_mobile/models/weather_model.dart'; // Assurez-vous que vous avez bien ce modèle
import 'package:waestro_mobile/styles/app_styles.dart'; // Import de AppStyle

class WeatherResultPage extends StatelessWidget {
  final Weather weather;

  WeatherResultPage({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppStyle.backgroundColor, // Utilisation de la couleur de fond
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Rendre l'appbar transparent
        iconTheme: IconThemeData(
            color: AppStyle.primaryTextColor), // Couleur de l'icône
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre principal
                Text(
                  weather.cityName,
                  style:
                      AppStyle.cityNameStyle, // Style pour le nom de la ville
                ),
                SizedBox(height: 10),

                // Température actuelle et ressenti
                Text(
                  '${weather.temp}°',
                  style: AppStyle.tempStyle, // Style pour la température
                ),
                Text(
                  'Real feel ${weather.feelslike}°',
                  style: AppStyle.realFeelStyle, // Style pour le ressenti
                ),
                SizedBox(height: 20),

                // Date d'aujourd'hui
                Text(
                  DateFormat('dd MMMM, EEEE')
                      .format(DateTime.now()), // Date formatée
                  style: AppStyle.dateStyle, // Style pour la date
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          // Prévisions du jour et des jours suivants avec un fond en dégradé
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(-1, 1),
                  colors: <Color>[
                    Color(0xFF101010), // Couleur de début
                    Color.fromARGB(255, 38, 40, 55), // Couleur de fin
                  ],
                  tileMode: TileMode.mirror, // Mode de tuile
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: weather.days.length,
                  itemBuilder: (context, index) {
                    final day = weather.days[index];
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          title: Text(
                            '${DateFormat('dd MMMM').format(day.date)}', // Formatage de la date
                            style: AppStyle
                                .dayTitleStyle, // Style pour le titre du jour
                          ),
                          subtitle: Text(
                            'Max: ${day.maxTemp}°C - Min: ${day.minTemp}°C',
                            style: AppStyle
                                .daySubtitleStyle, // Style pour le sous-titre
                          ),
                          trailing: Text(
                            day.condition, // Condition météo
                            style: AppStyle
                                .conditionStyle, // Style pour la condition météo
                          ),
                        ),
                        Divider(
                            color:
                                AppStyle.dividerColor), // Ligne de séparation
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
