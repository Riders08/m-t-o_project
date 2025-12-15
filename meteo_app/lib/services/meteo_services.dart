import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/meteo.dart';

class MeteoServices {
  static const String _apiKey = 'b4750e8985606b88bdc8be1bfe178a73';
  static const String _url = "https://api.openweathermap.org/data/2.5/weather";

  Future<Meteo> fetchMeteo(String location) async {
    final url = '$_url?q=$location&units=metric&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      return Meteo.fromJson(jsonData);
    }else{
      throw Exception("La récupération des données de l'API a échouée !");
    }
  }

  Future<Position> _getPosition() async {
    LocationPermission autoriwed;
    bool serviceEnable;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(serviceEnable){
      autoriwed = await Geolocator.checkPermission();
      if(autoriwed != LocationPermission.denied){
        if(autoriwed == LocationPermission.deniedForever){
          throw Exception("Permission de récupération de localisation refusée définitivement.");
        }
        return await Geolocator.getCurrentPosition();
      }else{
        autoriwed = await Geolocator.requestPermission();
        if(autoriwed == LocationPermission.denied){
          throw Exception("Vous n'avez pas autorisé la récupération de votre localisation.");
        }
      }
    }else{
      throw Exception("Votre localisation est désactivé.");
    }
  }
}