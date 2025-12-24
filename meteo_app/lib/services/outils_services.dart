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