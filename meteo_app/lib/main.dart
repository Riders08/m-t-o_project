import 'package:flutter/material.dart';
import 'package:meteo_app/services/cityResearch_services.dart';
import 'package:meteo_app/services/notification_services.dart';

import 'package:meteo_app/models/meteo.dart';
import 'package:meteo_app/models/prevision.dart';
import 'package:meteo_app/models/cityResearch.dart';

import 'package:meteo_app/services/outils_services.dart';
import 'package:meteo_app/services/meteo_services.dart';
import 'package:meteo_app/services/prevision_services.dart';

import 'package:meteo_app/widgets/CityResearchWidgets.dart';
import 'package:meteo_app/widgets/PrevisionContent.dart';
import 'package:meteo_app/widgets/WeatherContent.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meteo_app/widgets/live_time.dart';
import 'generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final PrevisionServices _previsionServices = PrevisionServices();
  final CityResearchServices _cityResearchServices = CityResearchServices();
  final OutilsServices _outilsServices = OutilsServices();
  final TextEditingController _cityController = TextEditingController();

  Prevision? _prevision;
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
      await _loadfromLocationUser();
    }catch(_){
    }
  }

  @override
  void dispose(){
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _loadDefault() async {
    try{
      final resultMeteo = await _meteoServices.fetchMeteo();
      final resultPrevision = await _previsionServices.fetchPrevision();
      setState(() {
        _prevision = resultPrevision;
        _meteo = resultMeteo;
        _isloading = false;
      });
    }catch(e){
      setState(() {
        _error = e.toString();
        _isloading = false;
      });
    }
  }

  Future<void> _loadfromSelectedValue(CityResearch ville) async {
    try{
      final country = await _outilsServices.getCountryLocation(ville.latitude, ville.longitude);
      final lang = await _outilsServices.langFromCountry(country);
      final resultMeteo = await _meteoServices.fetchMeteoByCoordinatesWithLang(ville.latitude, ville.longitude);
      final resultPrevision = await _previsionServices.fetchPrevisionByCoordinatesWithLang(ville.latitude, ville.longitude);
      setState(() {
        _prevision = resultPrevision;
        _meteo = resultMeteo;
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

  Future<Meteo> _loadfromLocationUser() async {
    try{
      final position = await _outilsServices.getPosition();
      final country = await _outilsServices.getCountryLocation(position.latitude, position.longitude);
      final lang = await _outilsServices.langFromCountry(country);

      final resultMeteo = await _meteoServices.fetchMeteoByCoordinatesWithLang(position.latitude, position.longitude);
      final resultPrevision = await _previsionServices.fetchPrevisionByCoordinatesWithLang(position.latitude, position.longitude);
      
      setState(() {
        _prevision = resultPrevision;
        _meteo = resultMeteo;
        _error = null;
        _languageCode = lang;
        _isloading = false;
      });
      return resultMeteo;
    }catch (e) {
      await _loadDefault();
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
            appBar: AppBar(title: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(FontAwesomeIcons.bars),
                    onTap: (){
                      print("barre de menu demandé");
                    },
                  ),
                  Text(S.current.appTitle),
                  LiveTime(time: DateTime.now()),
                ],
              ),
            ),
            body:
              RefreshIndicator(
                onRefresh: () async {
                    await _loadfromLocationUser();
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
                                CityResearchWidgets(cityResearchServices: _cityResearchServices,
                                              onSubmitted: (value){
                                                setState(() =>
                                                  _isloading = true);
                                                _loadfromSelectedValue(value);
                                              },
                                  ),
                                const SizedBox(height: 20),
                                WeatherContent(
                                  isLoading : _isloading,
                                  error : _error,
                                  meteo :  _meteo,
                                ),
                                const SizedBox(height: 20),
                                PrevisionContent(
                                  isLoading: _isloading, 
                                  error: _error, 
                                  prevision: _prevision,
                                ),
                              ]  
                          )      
                  ),
                )
              ), 
              floatingActionButton: FloatingActionButton(onPressed:(){
                                      _loadfromLocationUser();
                                      "La position a été remis a jour";
                                    }, 
                                    child: Icon(FontAwesomeIcons.locationDot),
                                    ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        })
    );
  }
}

