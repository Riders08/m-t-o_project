import 'dart:ui';

import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'package:meteo_app/models/meteo.dart';

class WeatherResult extends StatelessWidget {
  final Meteo meteo;

  const WeatherResult({
    super.key,
    required this.meteo
  });

  @override
  Widget build(BuildContext context) {
    return Center(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),               
                  child: Card(
                        color: Color.fromARGB(26, 255, 255, 255),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: 
                                [
                                  Text(meteo.location, style: const TextStyle(fontSize: 24)), // Lieu choisi ou par default
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(meteo.minimum < meteo.temperature.toDouble()) Flexible(child:
                                        Text('(${meteo.minimum}${meteo.measure})',style: const TextStyle(fontSize: 16, color: Colors.blue),),
                                      ),
                                      const SizedBox(width: 8,),
                                      Text('${meteo.temperature}${meteo.measure}', style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold)),// température en Celsius
                                      const SizedBox(width: 8,),
                                      if(meteo.maximum > meteo.temperature.toDouble()) Flexible(child: 
                                        Text('(${meteo.maximum}${meteo.measure})',style: const TextStyle(fontSize: 16, color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row( 
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(Meteo.iconsForMeteo(meteo.icon),height: 32,width: 32), // Icon représentant le temps
                                          const SizedBox(width: 8),
                                          Text(meteo.description, style: const TextStyle(fontSize: 16)), // Le temps sous sa forme
                                        ]
                                      ),
                                      SizedBox(width: 4,height: 4,),
                                      Text("${S.current.feels_like}: ${meteo.ressentie} ${meteo.measure}"),
                                    ],
                                  )
                                ]
                            )
                          ),
                      ),
                ),
              )
            );     
  }
}

// Pour la suite trois choix s'offrent à moi 
// - Optimiser mon menu latéral
  // Faire en sorte que lorsque je clique sur le menu alors le logo fasse une animation avant disparaitre
    // - Choix theme (Donner la possibilité de selectionner son theme)
    // - Choix background (Donner la possibilité de mettre son propres fond d'ecran)
    // - choix language (Donner la possibilité de choisir la language de l'appli)
    // - choix parametres (Donner la possibilité de choisir ses droits(rediriger vers les parametres de l'application en gros ))
    // - choix historique (Donner la possibilité de voir les précèdentes recherche fais sur la barre de recherche)
// Ameliorer les prévisions
