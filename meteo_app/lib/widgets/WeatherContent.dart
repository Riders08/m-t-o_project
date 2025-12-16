import 'package:flutter/material.dart';
import 'package:meteo_app/models/meteo.dart';
import 'WeatherResult.dart';

class WeatherContent extends StatelessWidget{
  final bool isLoading; 
  final String? error; 
  final Meteo? meteo;

  const WeatherContent({
    super.key,
    required this.isLoading,
    required this.error,
    required this.meteo
  });

  @override
  Widget build(BuildContext context) {
    if(isLoading == true){
      return const CircularProgressIndicator();
    }

    if(error != null){
      return Text(error!);
    }

    return WeatherResult(meteo : meteo!);
  }
}