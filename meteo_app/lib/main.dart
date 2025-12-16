import 'package:flutter/material.dart';
import 'package:meteo_app/services/meteo_services.dart';
import 'package:meteo_app/models/meteo.dart';

import 'package:meteo_app/widgets/CityResearch.dart';
import 'package:meteo_app/widgets/WeatherContent.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MeteoApp());
}

class MeteoApp extends StatefulWidget  {
  const MeteoApp({super.key});

  @override
  State<MeteoApp> createState() => _MeteoAppState();
}

class _MeteoAppState extends State<MeteoApp>  {
  final MeteoServices _meteoServices = MeteoServices();
  Meteo? _meteo;
  bool _isloading = true;
  String? _error;
  String? _languageCode;

  @override
  void initState() {
    super.initState();
    _initMeteo();
  }

  Future<void> _initMeteo() async {
    try{
      await _loadMeteofromLocationUser();
    }catch(_){
    }
  }

  Future<void> _loadMeteo() async {
    try{
      final result = await _meteoServices.fetchMeteo();
      setState(() {
        _meteo = result;
        _isloading = false;
      });
    }catch(e){
      setState(() {
        _error = e.toString();
        _isloading = false;
      });
    }
  }

  Future<void> _loadMeteofromSelectedValue(String value) async {
    try{
      final result = await _meteoServices.fetchMeteoWithLang(value);
      setState(() {
        _meteo = result;
        _isloading = false;
        _error = null;
      });
    }catch(e){
      setState(() {
        _error = S.current.cityNotFound;
        _isloading = false;
      });
    }
  }

  Future<Meteo> _loadMeteofromLocationUser() async {
    try{
      final position = await _meteoServices.getPosition();
      final country = await _meteoServices.getCountryLocation(position.latitude, position.longitude);
      final lang = await _meteoServices.langFromCountry(country);

      final result = await _meteoServices.fetchMeteoByCoordinatesWithLang(position.latitude, position.longitude);
      setState(() {
        _meteo = result;
        _error = null;
        _languageCode = lang;
        _isloading = false;
      });
      return result;
    }catch (e) {
      await _loadMeteo();
      setState(() {
        _languageCode = "en";
        _error = S.current.locationError;
        _isloading = false;
      });
      rethrow;
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(_languageCode ?? "en"), // ?? => par défaut
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Builder(
        builder: (context) { 
          return Scaffold(
            appBar: AppBar(title: Text(S.current.appTitle)),
            body: 
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: 
                    [
                      CityResearch(onSubmitted: (value){
                        setState(() =>
                          _isloading = true);
                        _loadMeteofromSelectedValue(value);
                      }),
                      const SizedBox(height: 20),

                      Expanded(
                        child: Center(
                          child : WeatherContent(
                            isLoading : _isloading,
                            error : _error,
                            meteo :  _meteo,
                          )
                        )
                      ) // Resultat de base
                ])
              )
          );
        })
    );
  }
}

