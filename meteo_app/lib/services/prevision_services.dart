import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:meteo_app/models/prevision.dart';
import 'package:meteo_app/services/outils_services.dart';

import '../generated/l10n.dart';

class PrevisionServices {
  static const String _apiKey = 'b4750e8985606b88bdc8be1bfe178a73';
  static const String _url = "https://api.openweathermap.org/data/2.5/forecast";
  static final OutilsServices _outils = OutilsServices();

  Future<Prevision> fetchPrevision() async {
    List<Location> listLocations = await locationFromAddress("Bordeaux");
    final longitude = listLocations.first.longitude;
    final latitude = listLocations.first.latitude;
    final countryCode = await _outils.getCountryLocation(latitude, longitude);
    final measure = _outils.measureFromCountry(countryCode);
    final url = '$_url?q=Bordeaux&units=$measure&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return Prevision.fromJson(json.decode(response.body), measure);
    }else{
      throw Exception(S.current.bigError);
    }
  }


  Future<Prevision> fetchPrevisionWithLang(String location) async {
    List<Location> listLocations = await locationFromAddress(location);
    final longitude = listLocations.first.longitude;
    final latitude = listLocations.first.latitude;
    final countryCode = await _outils.getCountryLocation(latitude, longitude);
    final lang = _outils.langFromCountry(countryCode);
    final measure = _outils.measureFromCountry(countryCode);
    final url = '$_url?q=$location&units=$measure&lang=$lang&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return Prevision.fromJson(json.decode(response.body), measure);
    }else{
      throw Exception(S.current.getDataAPIError);
    }
  }

  Future<Prevision> fetchPrevisionByCoordinatesWithLang(double lat, double lon) async {
    final countryCode = await _outils.getCountryLocation(lat, lon);
    final lang = _outils.langFromCountry(countryCode);
    final measure = _outils.measureFromCountry(countryCode);
    final url = '$_url?lat=$lat&lon=$lon&units=$measure&lang=$lang&appid=$_apiKey';
    final result = await http.get(Uri.parse(url));
    if(result.statusCode == 200){
      return Prevision.fromJson(json.decode(result.body), measure);
    }else{
      throw Exception(S.current.getLocationError);
    }
  }

}