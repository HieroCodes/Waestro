import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waestro_mobile/models/day_model.dart';
import 'package:waestro_mobile/pages/weather_details_page.dart';
import 'package:waestro_mobile/models/weather_model.dart';

import '../styles/app_styles.dart';


class WeatherDetailsPage extends StatelessWidget {
  final Day weatherDay;
  final String cityName;

  // Constructeur pour recevoir les données météo du jour
  WeatherDetailsPage({required this.weatherDay, required this.cityName});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              // Partie supérieure avec une image en arrière-plan
              Container(
                height: screenHeight * 0.6,
                width: screenWidth,// 60% de la hauteur de l'écran
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/bg.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom de la ville
                    Text(
                      cityName,
                      style: AppStyle.cityNameStyle,
                    ),
                    const SizedBox(height: 10),

                    // Date de l'élément cliqué
                    Text(
                      DateFormat('dd MMMM, EEEE').format(weatherDay.date),
                      style: AppStyle.dateStyle,
                    ),
                    const SizedBox(height: 10),

                    // Température
                    Text(
                      '${weatherDay.maxTemp}°C', // Température maximale de la journée
                      style: AppStyle.tempStyle,
                    ),
                    const SizedBox(height: 10),

                    // Visibilité
                    Text(
                      'Visibility: ${weatherDay.hours.first.visibility} km', // Visibilité
                      style: AppStyle.realFeelStyle,
                    ),
                    const SizedBox(height: 10),

                    // Humidité
                    Text(
                      'Humidity: ${weatherDay.hours.first.humidity}%', // Humidité
                      style: AppStyle.realFeelStyle,
                    ),
                    const SizedBox(height: 10),

                    // Vent
                    Text(
                      'Wind: ${weatherDay.hours.first.windSpeed} km/h', // Vitesse du vent
                      style: AppStyle.realFeelStyle,
                    ),
                  ],
                ),
              ),

              // Partie inférieure avec un fond dégradé
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF101010),
                        Color(0xFF262837),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Contenu ici',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // AppBar en superposition à l'extrême gauche en haut
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: AppStyle.primaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }




}
