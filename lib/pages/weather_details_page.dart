import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:waestro_mobile/models/day_model.dart';

import '../components/weather_color_indicator.dart';
import '../components/weather_format_hour.dart';
import '../models/weather_model.dart';
import '../styles/app_styles.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Day weatherDay;
  final Weather weather;

  // Constructeur pour recevoir les données météo du jour
  WeatherDetailsPage({required this.weatherDay,required this.weather});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final DateTime firstHour = weatherDay.hours.first.time;


    return Scaffold(
      backgroundColor:
      AppStyle.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.70, // Limite à 40% de la hauteur de l'écran
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      weatherDay.hours.first.getIsDayBackground()), // Image de fond du jour
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
                height: screenHeight * 0.70,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 23.0, top: 100.0, right: 23.0),
                  child: Column(
                    children: [
                      //CityName & MaxTemp
                      Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  Text(
                                    weather.cityName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                      DateFormat('EEE, dd MMMM').format(weatherDay.date),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${weatherDay.hours.first.temp}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 55,
                                      color: Colors.white
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text(
                                    '°C',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        color: Colors.white
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ]

                          )
                      ),
                      //const SizedBox(height: 15),
                      /*Expanded(
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
                      ),*/
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Cloud',
                                    style: AppStyle.detailsTitleStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weatherDay.hours.first.cloud}%', // Total Cloud
                                        style: AppStyle.realFeelStyle,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: getDotColor(weatherDay.hours.first.cloud.toDouble(), 'cloud'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Visibility', // Visibilité
                                    style: AppStyle.detailsTitleStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weatherDay.hours.first.visibility} km', // Visibilité
                                        style: AppStyle.realFeelStyle,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: getDotColor(weatherDay.hours.first.visibility, 'visibility'),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              const SizedBox(height: 50,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Moon Illumination',
                                    style: AppStyle.realFeelStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weatherDay.moonIllumination}%', // Moon Illumination (vérification si dispo)
                                        style: AppStyle.realFeelStyle,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: getDotColor(weatherDay.moonIllumination.toDouble(), 'moon_illumination'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Humidity', // Humidité
                                    style: AppStyle.detailsTitleStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weatherDay.hours.first.humidity}%', // Humidité
                                        style: AppStyle.realFeelStyle,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: getDotColor(weatherDay.hours.first.humidity.toDouble(), 'humidity'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Precipitation', // Précipitations
                                    style: AppStyle.realFeelStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weatherDay.hours.first.precipitation} mm', // Précipitations
                                        style: AppStyle.realFeelStyle,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: getDotColor(weatherDay.hours.first.precipitation, 'precipitation'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Wind', // Vents
                                    style: AppStyle.detailsTitleStyle,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${weatherDay.hours.first.windSpeed} km/h', // Vents
                                        style: AppStyle.realFeelStyle,
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: getDotColor(weatherDay.hours.first.windSpeed, 'wind'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          )

                        ],
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
                  width: screenWidth,
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
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 70,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 35.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Première colonne avec l'heure initiale
                            Column(
                              children: [
                                Text(
                                  formatHourWithSuffix(firstHour), // Afficher l'heure
                                  style: AppStyle.ForecastHourlyTimeStyle,
                                ),
                                const SizedBox(height: 30,),
                                SvgPicture.asset(
                                  weatherDay.hours.first.isDay 
                                    ? 'lib/assets/images/forecast_hourly/full.svg' 
                                    : weatherDay.getMoonPhaseImagePath(),
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(height: 30,),
                                Column(
                                  children: [
                                    Text(
                                      '${weatherDay.hours.first.temp}°', // Température pour cette heure
                                      style: AppStyle.daySubtitleStyle,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(width: 5,),
                                        Container(
                                          width: 15,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: getDotColor(weatherDay.hours.first.temp.toDouble(), 'temp'),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Deuxième colonne avec l'heure + 1
                            Column(
                              children: [
                                Text(
                                  formatHourWithSuffix(firstHour.add(Duration(hours: 1))),
                                  style: AppStyle.ForecastHourlyTimeStyle,
                                ),
                                const SizedBox(height: 30,),
                                SvgPicture.asset(
                                  weatherDay.hours[1].isDay 
                                    ? 'lib/assets/images/forecast_hourly/full.svg' 
                                    : weatherDay.getMoonPhaseImagePath(),
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(height: 30,),
                                Column(
                                  children: [
                                    Text(
                                      '${weatherDay.hours[1].temp}°', // Température pour cette heure
                                      style: AppStyle.daySubtitleStyle,
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      width: 15,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: getDotColor(weatherDay.hours[1].temp.toDouble(), 'temp'),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Troisième colonne avec l'heure + 2
                            Column(
                              children: [
                                Text(
                                  formatHourWithSuffix(firstHour.add(Duration(hours: 2))),
                                  style: AppStyle.ForecastHourlyTimeStyle,
                                ),
                                const SizedBox(height: 30,),
                                SvgPicture.asset(
                                  weatherDay.hours[2].isDay 
                                    ? 'lib/assets/images/forecast_hourly/full.svg' 
                                    : weatherDay.getMoonPhaseImagePath(),
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(height: 30,),
                                Column(
                                  children: [
                                    Text(
                                      '${weatherDay.hours[2].temp}°C', // Température pour cette heure
                                      style: AppStyle.daySubtitleStyle,
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      width: 15,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: getDotColor(weatherDay.hours[2].temp.toDouble(), 'temp'),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Quatrième colonne avec l'heure + 3
                            Column(
                              children: [
                                Text(
                                  formatHourWithSuffix(firstHour.add(Duration(hours: 3))),
                                  style: AppStyle.ForecastHourlyTimeStyle,
                                ),
                                const SizedBox(height: 30,),
                                SvgPicture.asset(
                                  weatherDay.hours[3].isDay 
                                    ? 'lib/assets/images/forecast_hourly/full.svg' 
                                    : weatherDay.getMoonPhaseImagePath(),
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(height: 30,),
                                Column(
                                  children: [
                                    Text(
                                      '${weatherDay.hours[3].temp}°C', // Température pour cette heure
                                      style: AppStyle.daySubtitleStyle,
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      width: 15,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: getDotColor(weatherDay.hours[3].temp.toDouble(), 'temp'),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Cinquième colonne avec l'heure + 4
                            Column(
                              children: [
                                Text(
                                  formatHourWithSuffix(firstHour.add(Duration(hours: 4))),
                                  style: AppStyle.ForecastHourlyTimeStyle,
                                ),
                                const SizedBox(height: 30,),
                                SvgPicture.asset(
                                  weatherDay.hours[4].isDay 
                                    ? 'lib/assets/images/forecast_hourly/full.svg' 
                                    : weatherDay.getMoonPhaseImagePath(),
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(height: 30,),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '${weatherDay.hours[4].temp}°C', // Température pour cette heure
                                      style: AppStyle.daySubtitleStyle,
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      width: 15,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: getDotColor(weatherDay.hours[4].temp.toDouble(), 'temp'),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            /*Center(
                              child: Text(
                                'Contenu ici', // Exemple de contenu
                                style: TextStyle(
                                  color: Colors.white, // Assurez-vous que le texte soit en blanc pour être visible
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor:
              Colors.transparent, // Rendre l'appbar transparente
              iconTheme: IconThemeData(
                  color: AppStyle.primaryTextColor), // Couleur de l'icône
              elevation: 0, // Retirer l'ombre pour un effet de transparence
            ),
          ),
        ],
      ),
    );
  }
}
