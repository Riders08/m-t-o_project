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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Météo')),
        body: Center(
          child: _isloading
          ? const CircularProgressIndicator()
          : _error != null
            ? Text(_error!)
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_meteo!.location, style: const TextStyle(fontSize: 24)),
                Text('${_meteo!.temparature} °C', style: const TextStyle(fontSize: 40)),
                Text(_meteo!.description),
              ],
            ),
        )
      )
    );
  }
}

