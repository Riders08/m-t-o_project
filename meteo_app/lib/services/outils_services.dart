import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meteo_app/models/models.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../generated/l10n.dart';

class OutilsServices {
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

  String measureFromCountry(String countryCode){
    switch(countryCode){
      case "FR" : return "metric";
      case "BE" : return "metric";
      case "CH" : return "metric";
      case "CA" : return "metric"; 
      case "US" : return "imperial";
      case "EN" : return "metric";
      case "GB" : return "metric"; 
      case "ES" : return "metric";
      case "MX" : return "metric"; 
      case "DE" : return "metric";
      case "IT" : return "metric"; 
      case "PT" : return "metric";
      case "BR" : return "metric"; 
      case "NL" : return "metric"; 
      case "JP" : return "metric"; 
      case "CN" : return "metric";
      case "TW" : return "metric"; 
      case "KR" : return "metric"; 
      case "RU" : return "metric"; 
      case "PL" : return "metric"; 
      case "UA" : return "metric"; 
      default : return "metric"; 
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

  Future<bool> checkInternet() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com')).timeout(
        const Duration(seconds: 3),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> activateLocalisation() async {
    return  await Geolocator.isLocationServiceEnabled();
  }

  Future<bool> autoriwedLocalisation() async {
    LocationPermission autoriwed = await Geolocator.checkPermission();
    if(autoriwed != LocationPermission.denied && autoriwed != LocationPermission.deniedForever){
      return true;
    } 
    return false;
  }

  Future<void> demandLocalisation() async {
    await Geolocator.requestPermission();
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

  Future<void> saveMyPosition(SavedPosition position) async {
    final value = await SharedPreferences.getInstance();
    value.setDouble("lon", position.longitude);
    value.setDouble("lat", position.latitude);
  }

  Future<void> saveSearchHistory(SearchHistory history) async {
    final value = await SharedPreferences.getInstance();

    final List<String> historyList = value.getStringList('searchHistory') ?? [];

    historyList.removeWhere((research) {
      final decode = SearchHistory.fromJson(jsonDecode(research));
      return decode.cityName == history.cityName;
    });//NOT DOUBLE

    historyList.add(jsonEncode(history.toJson()));
    if(historyList.length > 10){
      historyList.removeAt(0);
    }// limit => 10 
    await value.setStringList('searchHistory', historyList);
  }

  Future<SavedPosition?> loadMyPosition() async{
    final position = await SharedPreferences.getInstance();
    final lat = position.getDouble("lat");
    final lon = position.getDouble("lon");
    if(lat == null || lon == null){
      return null;
    }else{
      return SavedPosition(latitude: lat, longitude: lon);
    }
  }

  Future<List<SearchHistory>> loadSearchHistory() async {
    final value = await SharedPreferences.getInstance();
    final List<String> history = value.getStringList('searchHistory') ?? [];
    return history.map((research) => SearchHistory.fromJson(jsonDecode(research))).toList();
    
  }

  Future<bool> hasLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

}