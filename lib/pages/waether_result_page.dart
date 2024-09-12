import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importez ce package pour afficher les SVG dans Flutter
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
                height: MediaQuery.of(context).size.height *
                    0.40, // Limité à 40% de la hauteur de l'écran
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                      0.5), // Semi-transparent pour que le texte soit lisible
                ),
                child: Padding(
                  padding: const EdgeInsets.all(42.0),
                  child: Row(
                    children: [
                      // Colonne pour la ville, la date et la température ressentie
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Aligne les éléments à gauche
                        children: [
                          // Espace flexible pour pousser le contenu vers le haut
                          Text(
                            weather.cityName,
                            style: AppStyle
                                .cityNameStyle, // Style pour le nom de la ville
                          ),
                          SizedBox(height: 10),

                          // Température ressentie
                          Text(
                            'Real feel ${weather.feelslike}°',
                            style: AppStyle
                                .realFeelStyle, // Style pour le ressenti
                          ),

                          Spacer(), // Espace flexible pour pousser la date vers le bas

                          // Date d'aujourd'hui
                          Text(
                            DateFormat('dd MMMM, EEE').format(DateTime.now()), // Date formatée avec jour abrégé
                            style: AppStyle.dateStyle, // Style pour la date
                          ),
                        ],
                      ),

                      Spacer(), // Espace flexible pour pousser la température à droite

                      // Température principale à droite
                      Text(
                        '${weather.temp}°',
                        style: AppStyle.tempStyle, // Style pour la température
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
                    padding: const EdgeInsets.only(
                        left: 42.0, top: 15.0, right: 42.0),
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