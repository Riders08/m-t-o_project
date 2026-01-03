import 'meteo.dart';

class Prevision {
  final List<Meteo> previsions;

  const Prevision({
    required this.previsions,
  });

  factory Prevision.fromJson(Map<String,dynamic> json, String unit){
    final location = json['city']['name'];
    final listPrevisionJson = json['list'] as List;
    final meteos = listPrevisionJson.map((e) => Meteo.fromPrevisionJson(e, unit, location)).toList();
    return Prevision(previsions: meteos);
  }
}