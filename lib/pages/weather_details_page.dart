import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waestro_mobile/models/day_model.dart';

import '../models/weather_model.dart';
import '../styles/app_styles.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Day weatherDay;
  final Weather weather;
  final String cityName;

  // Constructeur pour recevoir les données météo du jour
  WeatherDetailsPage({required this.weatherDay,required this.weather,required this.cityName});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Rendre l'appbar transparent
        iconTheme: IconThemeData(color: AppStyle.primaryTextColor), // Couleur de l'icône
      ),
      body: Stack(

        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.40, // Limite à 40% de la hauteur de l'écran
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      weather.getIsDayBackground()), // Image de fond du jour
                  fit: BoxFit
                      .cover, // Assure que l'image couvre tout le conteneur
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              // Utilisation d'un Container avec une hauteur de 40% de la hauteur totale de l'écran
              Container(
                height: screenHeight * 0.40,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cityName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${weatherDay.maxTemp}°C',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.white
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ]

                          )
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('dd MMMM, EEEE').format(weatherDay.date),
                                  style: AppStyle.dateStyle,
                                ),
                              ]

                          )
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Total des nuages (cloud)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Cloud: ${weatherDay.hours.first.cloud}%', // Total Cloud
                                  style: AppStyle.realFeelStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Visibilité (vis_km)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Visibility: ${weatherDay.hours.first.visibility} km', // Visibilité
                                  style: AppStyle.realFeelStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Humidité (humidity)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Humidity: ${weatherDay.hours.first.humidity}%', // Humidité
                                  style: AppStyle.realFeelStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Précipitations (precip_mm)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Precipitation: ${weatherDay.hours.first.precipitation} mm', // Précipitations
                                  style: AppStyle.realFeelStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Moon Illumination (si disponible dans forecast)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Moon Illumination: ${weatherDay.hours.first.precipitation ?? 'N/A'}%', // Moon Illumination (vérification si dispo)
                                  style: AppStyle.realFeelStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Vent (wind_kph)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Wind: ${weatherDay.hours.first.windSpeed} km/h', // Vents
                                  style: AppStyle.realFeelStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),



                      Spacer(), // Espace flexible pour pousser la température à droite

                      const SizedBox(height: 10),
                    ],
                  ),
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
                    padding: const EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                    child: Center(
                      child: Text(
                        'Contenu ici', // Exemple de contenu
                        style: TextStyle(
                          color: Colors.white, // Assurez-vous que le texte soit en blanc pour être visible
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
