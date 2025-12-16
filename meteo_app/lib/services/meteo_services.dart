import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/meteo.dart';

class MeteoServices {
  static const String _apiKey = 'b4750e8985606b88bdc8be1bfe178a73';
  static const String _url = "https://api.openweathermap.org/data/2.5/weather";
  

  Future<String> getCountryLocation(double lat, double lon) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    final firstplacemark = placemarks.first;
    final countryCode = firstplacemark.isoCountryCode;
    if(countryCode != null){
      return placemarks.first.isoCountryCode!;
    }else{
      return "US";
    }
  }

  String langFromCountry(String countryCode){
    switch(countryCode){
      case "FR" : return "fr";
      case "BE" : return "fr";
      case "CA" : return "fr";
      case "GB" : return "en";
      case "EN" : return "en";
      case "US" : return "en";
      case "IT" : return "it";
      case "ES" : return "es";
      case "MX" : return "es";
      case "JP" : return "ja";
      case "DE" : return "de";
      case "CN" : return "zh";
      case "TW" : return "zh";
      default : return "en";
    }
  }

  Future<Meteo> fetchMeteo() async {
    final url = '$_url?q=&units=metric&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return Meteo.fromJson(json.decode(response.body));
    }else{
      throw Exception("Erreur énorme");
    }
  }

  Future<Meteo> fetchMeteoWithLang(String location) async {
    List<Location> listLocations = await locationFromAddress(location);
    final longitude = listLocations.first.longitude;
    final latitude = listLocations.first.latitude;
    final countryCode = await getCountryLocation(latitude, longitude);
    final lang = langFromCountry(countryCode);
    final url = '$_url?q=$location&units=metric&lang=$lang&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      return Meteo.fromJson(jsonData);
    }else{
      throw Exception("La récupération des données de l'API a échouée !");
    }
  }

  Future<Meteo> fetchMeteoByCoordinatesWithLang(double lat, double lon) async {
    final countryCode = await getCountryLocation(lat, lon);
    final lang = langFromCountry(countryCode);
    final url = '$_url?lat=$lat&lon=$lon&units=metric&lang=$lang&appid=$_apiKey';
    final result = await http.get(Uri.parse(url));
    if(result.statusCode == 200){
      return Meteo.fromJson(json.decode(result.body));
    }else{
      throw Exception("Erreur lors de la récupération de votre localisation");
    }
  }

  Future<Position> getPosition() async {
    LocationPermission autoriwed;
    bool serviceEnable;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnable){
      throw Exception("Votre localisation est désactivé");
    }

    autoriwed = await Geolocator.checkPermission();
    if(autoriwed == LocationPermission.denied){
      autoriwed = await Geolocator.requestPermission();
      if(autoriwed == LocationPermission.denied){
        throw Exception("Vous n'avez pas donnée l'autorisation à avoir accès à votre localisation.");
      }
    } 

    if(autoriwed == LocationPermission.deniedForever){
      throw Exception("Permission de récupération de localisation refusée définitivement.");
    }
    
    return await Geolocator.getCurrentPosition()
                  .timeout(
                    const Duration(seconds: 10),
                    onTimeout: () {
                      throw Exception("La récupération de votre localisation à mis trop de temps");
                    }
                  );
  }

}