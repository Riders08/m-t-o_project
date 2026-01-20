import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteo_app/services/cityResearch_services.dart';
import 'package:meteo_app/services/notification_services.dart';

import 'package:meteo_app/models/meteo.dart';
import 'package:meteo_app/models/prevision.dart';
import 'package:meteo_app/models/cityResearch.dart';

import 'package:meteo_app/services/outils_services.dart';
import 'package:meteo_app/services/meteo_services.dart';
import 'package:meteo_app/services/prevision_services.dart';

import 'package:meteo_app/widgets/CityResearchWidgets.dart';
import 'package:meteo_app/widgets/PressIcon.dart';
import 'package:meteo_app/widgets/PrevisionContent.dart';
import 'package:meteo_app/widgets/WeatherContent.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meteo_app/widgets/live_time.dart';
import 'generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationServices.initNotif();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
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
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();

  bool _drawerOpen = false;
  bool _appReady = false;
  bool _firstConnection = false;
  bool _connected = false;
  Prevision? _prevision;
  Meteo? _meteo;
  bool _isloading = true;
  String? _error;
  String? _languageCode;

  @override
  void initState() {
    super.initState();
    _initNotification();
    Future.delayed(const Duration(milliseconds: 300), () async {
      bool result = await _outilsServices.checkInternet();
      setState(() => 
        _connected = result
      );
    });
    //Dynamique
    Connectivity().onConnectivityChanged.listen((result) async {
      bool hasInternet = await _outilsServices.checkInternet();
      if(_firstConnection && hasInternet && _appReady){  
         _scaffoldMessageKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("Connexion Internet rétablie !"),
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 755, left: 10, right: 10),
            backgroundColor: Colors.green,
          ),
        );
        await _initMeteo();
      }
      if(_firstConnection && hasInternet && !_appReady){
        _scaffoldMessageKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("Connexion Internet établie !"),
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 755, left: 10, right: 10),
            backgroundColor: Colors.green,
          ),
        );
        await _initMeteo();
      }
      setState(() => 
        _connected = hasInternet
      );
      _firstConnection = true;
    });
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
        _appReady = true;
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
        _appReady = true;
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
      scaffoldMessengerKey: _scaffoldMessageKey,
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
          if(_connected){
            return _appReady ? _buildMainApp() : _buildSplashHome();
          }else{
            return _buildSplashHome();
          }
        })
    );
  }

  Widget _buildSplashHome() {
    return Scaffold(
      body: _connected ?
        SizedBox.expand(
          child: Image.asset(
            "assets/home.jpg",
            fit: BoxFit.cover,
          ),
        )
        : Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                          "assets/home.jpg", 
                          fit: BoxFit.cover
                        ),
              ),
              if (!_connected)
                Positioned(
                  top: 30,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Pas de connexion Internet",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ) 
    );
  }
  

  Widget _buildMainApp(){
    return Stack(
      children: [
        Positioned.fill( // Background
          child: Image.asset(
            _meteo == null 
            ? "assets/home.jpg"
            : Meteo.backgroundForMeteo(_meteo!.icon)
          ,fit: BoxFit.cover,width: double.infinity ,height: double.infinity) 
        ),
        Positioned.fill(
          child: Container(
            color:  Colors.black.withAlpha(90),
          )
        ), Scaffold(
            backgroundColor: Colors.transparent, // Obliger si le background par défaut va supperposé mon background
            resizeToAvoidBottomInset: false, // Obliger pour le clavier
            extendBodyBehindAppBar: true, //Essentiel si on veux que le background s'adapte à l'écran et pas au body
            onDrawerChanged:(isOpened) {
              setState(() {
                _drawerOpen = isOpened;
              });
            },
            drawer: Drawer(
                    backgroundColor: Colors.blue,
                    child: ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            children: [
                              DrawerHeader(
                                decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255)),
                                child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Title(color: Colors.black ,child: Text(S.current.appTitle, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.grey),)),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("data"),
                                              Text("datrhzrhzrha"),
                                            ],
                                          ),
                                        ],
                                      )      
                              )
                            ],
                          ),
                    ),
            appBar: 
              AppBar(
              backgroundColor: Colors.blue,
              centerTitle: true,
              leading: 
                Builder(
                  builder: (context) => PressIcon(
                    icon: FontAwesomeIcons.bars, 
                    open: _drawerOpen,
                    onTap: () async {
                      setState(() => _drawerOpen = true);
                      await Future.delayed(const Duration(milliseconds: 300));
                      Scaffold.of(context).openDrawer();
                    }
                  ), 
                ),
              title: Text(S.current.appTitle, style: TextStyle(color: Colors.white),),
              actions: [
                Padding(
                  padding: const EdgeInsetsGeometry.only(right: 12),
                  child: LiveTime(time: DateTime.now(),)
                ),
              ]
            ),
            body:
              SafeArea( // Ensemble du contenu
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: _appReady ? 1 : 0,
                  child: IgnorePointer(
                      ignoring: !_appReady,
                      child: RefreshIndicator(
                        onRefresh: () async {
                            await _loadfromLocationUser();
                            setState(() {
                              FocusManager.instance.primaryFocus?.unfocus();
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
                                        CityResearchWidgets(cityController: _cityController, cityResearchServices: _cityResearchServices, // Barre de recherche
                                                      onSubmitted: (value){
                                                        setState(() =>
                                                          _isloading = true);
                                                        _loadfromSelectedValue(value);
                                                      },
                                          ),
                                        const SizedBox(height: 20),
                                        WeatherContent( // Le temps actuelle
                                          isLoading : _isloading,
                                          error : _error,
                                          meteo :  _meteo,
                                        ),
                                        const SizedBox(height: 20),
                                        PrevisionContent( //Les previsions
                                          isLoading: _isloading, 
                                          error: _error, 
                                          meteo: _meteo,
                                          prevision: _prevision,
                                        ),
                                      ]  
                                  ),      
                                ),
                          )
                      ,)
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(onPressed:(){ // Bouton qui remet a jour avec la localisation
                                      _loadfromLocationUser();
                                      setState(() {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        _cityController.clear();
                                      });
                                    }, 
                                    backgroundColor: Colors.blue,
                                    child: Icon(FontAwesomeIcons.locationDot, color: Colors.white,),
                                    ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              ),
            ],
          );
    }
}



// Penser a finir les message de connection internet (faire en sorte que s'affiche bien en haut que l'on ne voit pas les deux a la fois)