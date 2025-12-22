import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/meteo.dart';

import '../generated/l10n.dart';

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
      return "FR";
    }
  }

  String langFromCountry(String countryCode){
    switch(countryCode){
      case "FR" : return "fr";
      case "BE" : return "fr";
      case "CH" : return "fr";
      case "CA" : return "fr"; //Français
      case "US" : return "en";
      case "EN" : return "en";
      case "GB" : return "en"; // Anglais
      case "ES" : return "es";
      case "MX" : return "es"; // Espagnol
      case "DE" : return "de"; // Allemand
      case "IT" : return "it"; // Italien
      case "PT" : return "pt";
      case "BR" : return "pt"; // Portugais
      case "NL" : return "nl"; // Néeerlandais
      case "JP" : return "ja"; // Japonais
      case "CN" : return "zh";
      case "TW" : return "zh"; // Chinois
      case "KR" : return "ko"; // Koréen
      case "RU" : return "ru"; // Russe
      case "PL" : return "pl"; // Polonais
      case "UA" : return "uk"; // Ukrainien
      default : return "en"; // Anglais par défault
    }
  }

  Future<Meteo> fetchMeteo() async {
    final url = '$_url?q=Bordeaux&units=metric&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return Meteo.fromJson(json.decode(response.body));
    }else{
      throw Exception(S.current.bigError);
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
      throw Exception(S.current.getDataAPIError);
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
      throw Exception(S.current.getLocationError);
    }
  }

  Future<Position> getPosition() async {
    LocationPermission autoriwed;
    bool serviceEnable;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnable){
      throw Exception(S.current.locationNotActive);
    }

    autoriwed = await Geolocator.checkPermission();
    if(autoriwed == LocationPermission.denied){
      autoriwed = await Geolocator.requestPermission();
      if(autoriwed == LocationPermission.denied){
        throw Exception(S.current.autoriwedLocationError);
      }
    } 

    if(autoriwed == LocationPermission.deniedForever){
      throw Exception(S.current.permissionLocationError);
    }
    
    return await Geolocator.getCurrentPosition()
                  .timeout(
                    const Duration(seconds: 10),
                    onTimeout: () {
                      throw Exception(S.current.getLocationTimeError);
                    }
                  );
  }

}