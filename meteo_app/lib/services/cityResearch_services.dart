import 'package:http/http.dart' as http;
import 'package:meteo_app/models/cityResearch.dart';
import 'dart:convert';


class CityResearchServices {
  static const String _apiKey = 'b4750e8985606b88bdc8be1bfe178a73';
  static const String _url = "https://api.openweathermap.org/geo/1.0/direct";

  Future<List<CityResearch>> searchCities(String value) async {
    if (value.length < 2){
      return [];
    } 
    final url = '$_url?q=$value&limit=4&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode != 200){
      throw Exception('Erreur API villes');
    }
    final List data = json.decode(response.body);

    return data.map((e) => CityResearch.fromJson(e)).toList();
  }
}