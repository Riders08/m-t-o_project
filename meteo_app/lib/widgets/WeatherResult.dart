import 'package:flutter/material.dart';
import 'package:meteo_app/models/meteo.dart';

class WeatherResult extends StatelessWidget {
  final Meteo meteo;

  const WeatherResult({
    super.key,
    required this.meteo
  });

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
              [
                Text(meteo.location, style: const TextStyle(fontSize: 24)), // Lieu choisi ou par default
                Text('${meteo.temperature} °C', style: const TextStyle(fontSize: 40)), // température en Celsius
                Text(meteo.description), // Le temps sous sa forme
              ]
            );      
  }
}