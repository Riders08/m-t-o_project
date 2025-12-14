class Meteo{
  final String location;
  final double temparature;
  final String measure;
  final String description;

  const Meteo({
    required this.location,
    required this.temparature,
    required this.measure,
    required this.description,
  });

  factory Meteo.fromJson(Map<String,dynamic> json){
    return Meteo(
      location: json['name'], 
      temparature: json['main']['temp'].toDouble(), 
      measure: "°C", 
      description: json['weather'][0]['description']
    );
  }
}