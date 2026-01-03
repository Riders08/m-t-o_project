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
              child: Card(
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
                                      Flexible(child:
                                        Text('(-${meteo.minimum}${meteo.measure})',style: const TextStyle(fontSize: 16, color: Colors.blue),),
                                      ),
                                      const SizedBox(width: 8,height: 10,),
                                      Text('${meteo.temperature}${meteo.measure}', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)), // température en Celsius
                                      const SizedBox(width: 8,),
                                      if(meteo.maximum != meteo.temperature) Flexible(child: 
                                        Text('(+${meteo.maximum}${meteo.measure})',style: const TextStyle(fontSize: 16, color: Colors.red)),
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
                                          Text(Meteo.iconsForMeteo(meteo.icon), style: const TextStyle(fontSize: 64)), // Icon représentant le temps
                                          const SizedBox(width: 8),
                                          Text(meteo.description, style: const TextStyle(fontSize: 16)), // Le temps sous sa forme
                                        ]
                                      ),
                                      Text("${S.current.feels_like}: ${meteo.ressentie} ${meteo.measure}"),
                                    ],
                                  )
                                ]
                            )
                          ),
                      ),
              );     
  }
}