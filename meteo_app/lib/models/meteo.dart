class Meteo{
  final String location;
  final double temperature;
  final String measure;
  final String description;
  final double ressentie;
  final double minimum;
  final double maximum;
  final String temps;
  final int pression;
  final int humidite;
  final String icon;

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
    required this.icon,
  });

  factory Meteo.fromJson(Map<String,dynamic> json, String unit){
    return Meteo(
      location: json['name'], 
      temperature: json['main']['temp'].toDouble(), 
      measure: Meteo.getMeasure(unit), 
      description: json['weather'][0]['description'],
      ressentie: json['main']['feels_like'].toDouble(),
      minimum: json['main']['temp_min'].toDouble(),
      maximum: json['main']['temp_max'].toDouble(),
      temps: json['weather'][0]['main'],
      pression: json['main']['pressure'],
      humidite: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
    );
  }

  static String getMeasure(String unit){
    if(unit == "metric"){
      return "°C";
    }else{
      return "°F";
    }
  }

  static String iconsForMeteo(String icons){
    switch(icons){
      case "01d": return "☀️";
      case "01n": return "🌙";
      case "02d": return "⛅";
      case "02n": return "🌙☁️";
      case "03d": return "☁️";
      case "03n": return "☁️";
      case "04d": return "☁️";
      case "04n": return "☁️";
      case "09d": return "🌧️";
      case "09n": return "🌧️";
      case "10d": return "🌦️";
      case "10n": return "🌧️";
      case "11d": return "⛈️";
      case "11n": return "⛈️";
      case "13d": return "❄️";
      case "13n": return "❄️"; 
      case "50d": return "🌫️";
      case "50n": return "🌫️";
      default: return "Erreur le code d'icons donnée est inconnu !";
    }
  }
}