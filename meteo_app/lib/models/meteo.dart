import 'dart:ffi';

class Meteo{
  final String location;
  final double temperature;
  final String measure;
  final String description;
  final double ressentie;
  final double minimum;
  final double maximum;
  final String temps;
  final Long pression;
  final Long humidite;

  const Meteo({
    required this.location,
    required this.temperature,
    required this.measure,
    required this.description,
    required this.ressentie,
    required this.minimum,
    required this.maximum,
    required this.temps,
    required this.pression,
    required this.humidite,
  });

  factory Meteo.fromJson(Map<String,dynamic> json){
    return Meteo(
      location: json['name'], 
      temperature: json['main']['temp'].toDouble(), 
      measure: "°C", 
      description: json['weather'][0]['description']
    );
  }
}