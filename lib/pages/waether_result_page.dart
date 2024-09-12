import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:intl/intl.dart';
import 'package:waestro_mobile/models/weather_model.dart';
import 'package:waestro_mobile/pages/weather_details_page.dart';
import 'package:waestro_mobile/styles/app_styles.dart'; 

class WeatherResultPage extends StatelessWidget {
  final Weather weather;

  WeatherResultPage({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppStyle.backgroundColor, // Utilisation de la couleur de fond
      body: Stack(
        children: [
          // Image de fond limitée à 40% de la hauteur de l'écran
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

          // Contenu principal
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, top: 60.0, right: 50.0, bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
                    children: [
                      // Nom de la ville aligné à gauche
                      Text(
                        weather.cityName,
                        style: AppStyle.cityNameStyle,
                      ),
                      SizedBox(height: 10),

                      // Ressenti aligné à gauche
                      Text(
                        'Real feel ${weather.feelslike}°',
                        style: AppStyle.realFeelStyle,
                      ),
                      SizedBox(height: 20),

                      // Température principale alignée à droite
                      Align(
                        alignment: Alignment.centerRight, // Alignement à droite
                        child: Text(
                          '${weather.temp}°',
                          style: AppStyle.tempStyle,
                        ),
                      ),
                      Spacer(),

                      // Date alignée à gauche
                      Text(
                        DateFormat('dd MMMM, EEE').format(DateTime.now()),
                        style: AppStyle.dateStyle,
                      ),
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
                    padding: const EdgeInsets.only(left: 38.0, top: 10.0, right: 38.0),
                    child: ListView.builder(
                      itemCount: weather.days.length,
                      itemBuilder: (context, index) {
                        final day = weather.days[index];
                        return Column(
                          children: [
                            ListTile(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 4.0),

                              // Utilisation d'un Row avec Expanded pour chaque élément
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Colonne 1 : Date formatée
                                  Expanded(
                                    flex:
                                    2, // Donne 2 fois plus d'espace à la date
                                    child: Text(
                                      '${DateFormat('dd MMM').format(day.date)}', // Date abrégée
                                      style: AppStyle
                                          .dayTitleStyle, // Style pour la date
                                    ),
                                  ),

                                  // Colonne 2 : Phase lunaire
                                  Expanded(
                                    flex: 1,
                                    child: SvgPicture.asset(
                                      day.getMoonPhaseImagePath(),
                                      width:
                                      24, // Largeur de l'image de la phase lunaire
                                      height:
                                      24, // Hauteur de l'image de la phase lunaire
                                    ),
                                  ),

                                  // Colonne 3 : Températures max/min
                                  Expanded(
                                    flex:
                                    3, // Espace suffisant pour les températures
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                            '${day.maxTemp}°C', // Température max
                                            style: AppStyle.daySubtitleStyle
                                                .copyWith(
                                              fontWeight:
                                              FontWeight.bold, // Gras
                                              color: Colors.white, // Blanc
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                            ' - ${day.minTemp}°C', // Température min
                                            style: AppStyle
                                                .daySubtitleStyle, // Style normal pour la température min
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Colonne 4 : Condition météo
                                  Expanded(
                                    flex: 2,
                                    child: Image.network(
                                      day.icon, // URL de l'image (icône météo)
                                      width: 24, // Largeur de l'icône
                                      height: 24, // Hauteur de l'icône
                                      fit: BoxFit
                                          .contain, // Ajuste l'image sans la déformer
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons
                                            .error); // Icône d'erreur en cas d'échec du chargement de l'image
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // Naviguer vers la page de détails avec les données de la journée sélectionnée
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WeatherDetailsPage(
                                        weatherDay: day,
                                        weather: weather,
                                    ), // Passer les données
                                  ),
                                );
                              },
                            ),

                            // Ligne de séparation
                            Divider(color: AppStyle.dividerColor),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          // AppBar en position absolue
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