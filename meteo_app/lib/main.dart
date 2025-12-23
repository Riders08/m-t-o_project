import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meteo_app/services/meteo_services.dart';
import 'package:meteo_app/services/notification_services.dart';

import 'package:meteo_app/models/meteo.dart';

import 'package:meteo_app/widgets/CityResearch.dart';
import 'package:meteo_app/widgets/WeatherContent.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationServices.initNotif();

  runApp(const MeteoApp());
}

class MeteoApp extends StatefulWidget  {
  const MeteoApp({super.key});

  @override
  State<MeteoApp> createState() => _MeteoAppState();
}

class _MeteoAppState extends State<MeteoApp>  {
  final MeteoServices _meteoServices = MeteoServices();
  final TextEditingController _cityController = TextEditingController();

  Meteo? _meteo;
  bool _isloading = true;
  String? _error;
  String? _languageCode;

  @override
  void initState() {
    super.initState();
    _initNotification();
    _initMeteo();
  }

  Future<void> _initNotification() async {
    final notification = NotificationServices();
    notification.DailyNotification(
      hour: 12, 
      minutes: 0, 
      title: 'Météo du jour', 
      body: 'Attention le temps chute actuellement'
    );
  }

  Future<void> _initMeteo() async {
    try{
      await _loadMeteofromLocationUser();
    }catch(_){
    }
  }

  @override
  void dispose(){
    _cityController.dispose();
    super.dispose();
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
      List<Location> listLocations = await locationFromAddress(value);
      final latitude = listLocations.first.latitude;
      final longitude = listLocations.first.longitude;
      final country = await _meteoServices.getCountryLocation(latitude, longitude);
      final lang = await _meteoServices.langFromCountry(country);
      final result = await _meteoServices.fetchMeteoByCoordinatesWithLang(latitude, longitude);
      setState(() {
        _meteo = result;
        _languageCode = lang;
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
      key: ValueKey(_languageCode),
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
              RefreshIndicator(
                onRefresh: () async {
                    await _loadMeteofromLocationUser();
                    setState(() {
                      _cityController.clear();
                    });
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: 
                              [
                                CityResearch(controller: _cityController, onSubmitted: (value){
                                  setState(() =>
                                    _isloading = true);
                                  _loadMeteofromSelectedValue(value);
                                }),
                                const SizedBox(height: 20),

                                 WeatherContent(
                                      isLoading : _isloading,
                                      error : _error,
                                      meteo :  _meteo,
                                    )
                              ]  
                          )      
                  ),
                )
              )
          );
        })
    );
  }
}

