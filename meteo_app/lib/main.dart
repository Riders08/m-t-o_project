import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meteo_app/models/savedPosition.dart';
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
import 'package:meteo_app/widgets/menu.dart';
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
  final OutilsServices _outilsServices = OutilsServices();

  final CityResearchServices _cityResearchServices = CityResearchServices();
  final TextEditingController _cityController = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();
  bool _drawerOpen = false;

  SavedPosition? _savePos;
  bool _firstConnection = false;
  bool _connected = false;

  bool _appReady = false;
  
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
      if(!hasInternet){
        _scaffoldMessageKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("Pas de connection internet"),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 755, left: 10, right: 10),
            backgroundColor: Colors.red,
          ),
        );
      }
      if(_firstConnection && hasInternet && _appReady){  
         _scaffoldMessageKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("Connexion Internet rétablie !"),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 755, left: 10, right: 10),
            backgroundColor: Colors.green,
          ),
        );
        await _initStart();
      }
      if(_firstConnection && hasInternet && !_appReady){
        _scaffoldMessageKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("Connexion Internet établie !"),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 755, left: 10, right: 10),
            backgroundColor: Colors.green,
          ),
        );
        await _initStart();
      }
      setState(() => 
        _connected = hasInternet
      );
      _firstConnection = true;
    });
    _initStart();
  }

  Future<void> _initStart() async {
    _connected = await _outilsServices.checkInternet();
    await _initLoad();   
    await _initMeteo();
  }

  Future<void> _initLoad() async {
    final data = await _outilsServices.loadMyPosition();
    _savePos = data;
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
    if(_connected){
      try{
        await _loadfromLocationUser();
        return;
      }catch(_){
      }
    }
    if(_savePos != null && _connected){
      await _loadfromAlreadyPosition(_savePos!);
      return;
    }
    await _loadDefault();
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
        _languageCode = "fr";
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

  Future<void> _loadfromAlreadyPosition(SavedPosition position) async{
    try{
      final country = await _outilsServices.getCountryLocation(position.latitude, position.longitude);
      final lang = _outilsServices.langFromCountry(country);
      final resultMeteo = await _meteoServices.fetchMeteoByCoordinatesWithLang(position.latitude,position.longitude);
      final resultPrevision = await _previsionServices.fetchPrevisionByCoordinatesWithLang(position.latitude,position.longitude);
      setState(() {
        _savePos = position;
        _prevision = resultPrevision;
        _meteo = resultMeteo;
        _languageCode = lang;
        _isloading = false;
        _error = null;
        _appReady = true;
      });
      _outilsServices.saveMyPosition(position);
    }catch(e){
      setState(() {
        _error = S.current.cityNotFound;
        _isloading = false;
      });
    }
  }

  Future<void> _loadfromSelectedValue(CityResearch ville) async {
    try{
      final country = await _outilsServices.getCountryLocation(ville.latitude, ville.longitude);
      final lang = _outilsServices.langFromCountry(country);
      final resultMeteo = await _meteoServices.fetchMeteoByCoordinatesWithLang(ville.latitude, ville.longitude);
      final resultPrevision = await _previsionServices.fetchPrevisionByCoordinatesWithLang(ville.latitude, ville.longitude);
      setState(() {
        _savePos = SavedPosition(latitude: ville.latitude, longitude: ville.longitude);
        _prevision = resultPrevision;
        _meteo = resultMeteo;
        _languageCode = lang;
        _isloading = false;
        _error = null;
        _appReady = true;
      });
      _outilsServices.saveMyPosition(SavedPosition(latitude: ville.latitude, longitude: ville.longitude));
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
      final lang = _outilsServices.langFromCountry(country);

      final resultMeteo = await _meteoServices.fetchMeteoByCoordinatesWithLang(position.latitude, position.longitude);
      final resultPrevision = await _previsionServices.fetchPrevisionByCoordinatesWithLang(position.latitude, position.longitude);
      
      final saved = SavedPosition(latitude: position.latitude, longitude: position.longitude);
      setState(() {
        _savePos = saved;
        _prevision = resultPrevision;
        _meteo = resultMeteo;
        _error = null;
        _languageCode = lang;
        _isloading = false;
        _appReady = true;
      });
      await _outilsServices.saveMyPosition(saved);
      _savePos = saved;
      return resultMeteo;
    }catch (e) {
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
      body:
        SizedBox.expand(
          child: Image.asset(
            "assets/home.jpg",
            fit: BoxFit.cover,
          ),
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
                  child: Menu()
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
              floatingActionButton: FloatingActionButton(onPressed:() async { // Bouton qui remet a jour avec la localisation
                                      if(await _outilsServices.autoriwedLocalisation()){
                                        if(await _outilsServices.activateLocalisation()){
                                          _loadfromLocationUser();
                                          setState(() {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            _cityController.clear();
                                          });
                                        }else{
                                          _scaffoldMessageKey.currentState?.showSnackBar(
                                            const SnackBar(
                                              content: Text("Votre localisation est désactivé !"),
                                              duration: Duration(seconds: 2),
                                              behavior: SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                                              backgroundColor: Colors.blue,
                                            ),
                                          );
                                        }
                                      }else{
                                        await _outilsServices.demandLocalisation();
                                        if (!await _outilsServices.autoriwedLocalisation()) {
                                          _scaffoldMessageKey.currentState?.showSnackBar(
                                            const SnackBar(
                                              content: Text("Permission localisation refusée !"),
                                              duration: Duration(seconds: 2),
                                              behavior: SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                                              backgroundColor: Colors.blue,
                                            ),
                                          );
                                        }
                                      }
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