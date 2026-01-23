import 'package:intl/intl.dart';

class Meteo{
  final String location;
  final int temperature;
  final String measure;
  final String description;
  final double ressentie;
  final double minimum;
  final double maximum;
  final String temps;
  final int pression;
  final int humidite;
  final String icon;
  final DateTime time;

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
    required this.time,
  });

  factory Meteo.fromJson(Map<String,dynamic> json, String unit){
    return Meteo(
      location: json['name'], 
      temperature: shortNumber(json['main']['temp'].toDouble()), 
      measure: Meteo.getMeasure(unit), 
      description: json['weather'][0]['description'],
      ressentie: json['main']['feels_like'].toDouble(),
      minimum: json['main']['temp_min'].toDouble(),
      maximum: json['main']['temp_max'].toDouble(),
      temps: json['weather'][0]['main'],
      pression: json['main']['pressure'],
      humidite: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true).toLocal(),
    );
  }

  factory Meteo.fromPrevisionJson(Map<String,dynamic> json, String unit, String city){
    return Meteo(
      location: city, 
      temperature: shortNumber(json['main']['temp'].toDouble()), 
      measure: Meteo.getMeasure(unit), 
      description: json['weather'][0]['description'],
      ressentie: json['main']['feels_like'].toDouble(),
      minimum: json['main']['temp_min'].toDouble(),
      maximum: json['main']['temp_max'].toDouble(),
      temps: json['weather'][0]['main'],
      pression: json['main']['pressure'],
      humidite: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true).toLocal(),
    );
  }

  static String getMeasure(String unit){
    if(unit == "metric"){
      return "°C";
    }else{
      return "°F";
    }
  }

  static int shortNumber(double number){
    double decimal = number - number.floor();
    if(decimal > 0.5){
      return number.ceilToDouble().toInt();
    }else{
      return number.floorToDouble().toInt();
    }
  }

  static String iconsForMeteo(String icons){
    switch(icons){
      case "01d": return "assets/icons/sun.png";
      case "01n": return "assets/icons/moon.png"; 
      case "02d": return "assets/icons/cloud-sun.png";
      case "02n": return "assets/icons/cloud-moon.png";
      case "03d": return "assets/icons/cloud.png";
      case "03n": return "assets/icons/cloud.png";
      case "04d": return "assets/icons/cloud.png";
      case "04n": return "assets/icons/cloud.png";
      case "09d": return "assets/icons/cloud-rain.png";
      case "09n": return "assets/icons/cloud-rain.png";
      case "10d": return "assets/icons/cloud-rain-sun.png";
      case "10n": return "assets/icons/cloud-rain-moon.png";
      case "11d": return "assets/icons/cloud-bolt.png"; 
      case "11n": return "assets/icons/cloud-bolt.png"; 
      case "13d": return "assets/icons/snow.png";
      case "13n": return "assets/icons/snow.png";
      case "50d": return "assets/icons/fog.png"; 
      case "50n": return "assets/icons/fog.png"; 
      default: return "assets/icons/error.png";
    }
  }

  static String backgroundForMeteo(String icons){
    switch(icons){
      case "01d": return "assets/theme/sun.jpg";
      case "01n": return "assets/theme/moon.png";
      case "02d": return "assets/theme/cloud-sun.gif";
      case "02n": return "assets/theme/cloud-moon.jpg";
      case "03d": return "assets/theme/cloud.gif";
      case "03n": return "assets/theme/cloud-night.gif";
      case "04d": return "assets/theme/cloud.gif";
      case "04n": return "assets/theme/cloud-night.gif";
      case "09d": return "assets/theme/rain.gif";
      case "09n": return "assets/theme/rain.gif"; 
      case "10d": return "assets/theme/rain.gif";
      case "10n": return "assets/theme/rain.gif";
      case "11d": return "assets/theme/cloud-bolt.gif";
      case "11n": return "assets/theme/cloud-bolt.gif"; 
      case "13d": return "assets/theme/snow-day.gif";
      case "13n": return "assets/theme/snow-night.gif";
      case "50d": return "assets/theme/fog.jpg";
      case "50n": return "assets/theme/fog.jpg"; 
      default: return "assets/icons/error.png";
    }
  }

  static String getDisplayTime(DateTime time, String local){
    final hour = DateFormat.Hm(local).format(time);
    final day = DateFormat.yMMMEd(local).format(time);
    return "$day : $hour";
  }

  static bool sameDay(DateTime today, DateTime check){
     return today.year == check.year && today.month == check.month && today.day == check.day;
  }

  static DateTime nextDay(DateTime locale){
    return DateTime(locale.year, locale.month, locale.day+1, 0 , 0, 0);
  }

  static bool isAfter(DateTime a, DateTime b){
    return a.isAfter(b);
  }
}