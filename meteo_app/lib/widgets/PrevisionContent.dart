import 'package:flutter/material.dart';
import 'package:meteo_app/models/prevision.dart';
import 'package:meteo_app/models/meteo.dart';
import 'package:meteo_app/widgets/PrevisionResult.dart';

class PrevisionContent extends StatelessWidget{
  final bool isLoading;
  final String? error;
  final Meteo? meteo;
  final Prevision? prevision;

  const PrevisionContent({
    super.key,
    required this.isLoading,
    required this.error,
    required this.meteo,
    required this.prevision,
  });

  @override
  Widget build(BuildContext context) {
    if(isLoading == true){
      return const CircularProgressIndicator();
    }
    if(error != null){
      return Text(error!);
    }
    return PrevisionResult(meteo: meteo!,prevision: prevision!);
  }

}