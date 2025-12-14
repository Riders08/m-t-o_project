import 'package:flutter/material.dart';
import 'package:meteo_app/services/meteo_services.dart';
import 'package:meteo_app/models/meteo.dart';

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

  @override
  void initState() {
    super.initState();
    _loadMeteo();
  }

  Future<void> _loadMeteo() async {
    try{
      final result = await _meteoServices.fetchMeteo('Paris');
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
      final result = await _meteoServices.fetchMeteo(value);
      setState(() {
        _meteo = result;
        _isloading = false;
        _error = null;
      });
    }catch(e){
      setState(() {
        _error = "Ville introuvable";
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Météo')),
        body: 
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: 
                [
                  TextField(
                    decoration: const InputDecoration(labelText: "Ville/Pays", border: OutlineInputBorder()),
                    onSubmitted: (value) {
                      setState(() {
                        _isloading = true;
                      });
                      _loadMeteofromSelectedValue(value);
                    }
                  ), //Formulaire de demande de ville/pays

                  const SizedBox(height: 20),

                  Expanded(
                    child: Center(
                      child: _isloading
                      ? const CircularProgressIndicator()
                      : _error != null // Check internet et tous les autres problemes
                        ? Text(_error!)
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: 
                          [
                            Text(_meteo!.location, style: const TextStyle(fontSize: 24)), // Lieu choisi ou par default
                            Text('${_meteo!.temparature} °C', style: const TextStyle(fontSize: 40)), // température en Celsius
                            Text(_meteo!.description), // Le temps sous sa forme
                          ]),
                    )
                  ) // Resultat de base
            ])
          )
      ),
    );
  }
}

