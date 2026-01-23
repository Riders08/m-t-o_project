import 'package:flutter/material.dart';
import 'package:meteo_app/models/prevision.dart';
import 'package:meteo_app/models/meteo.dart';


class PrevisionResult extends StatelessWidget{
  final Meteo meteo;
  final Prevision prevision;

  const PrevisionResult({
    super.key,
    required this.meteo,
    required this.prevision
  });

  @override
  Widget build(BuildContext context) {
    final localeTime = Localizations.localeOf(context).toString();
    final today = meteo.time;
    final tomorrow = Meteo.nextDay(today);

    final List<Meteo> previsionsToday = prevision.previsions.where((pre) => Meteo.sameDay(today, pre.time)).toList();
    final List<Meteo> previsionsTomorrow = prevision.previsions.where((preT) => Meteo.sameDay(tomorrow, preT.time)).toList();

    final displayPrevisions = previsionsToday.isNotEmpty ? previsionsToday : previsionsTomorrow; 

    final List<Meteo> displayPrevisionsExtension = prevision.previsions.where((preExt) => Meteo.isAfter(preExt.time, displayPrevisions.last.time)).toList();
    

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayPrevisions.length,
            itemBuilder: (context, index){
              final preMeteo = displayPrevisions[index];
              return ListTile(
                leading: Image.asset(Meteo.iconsForMeteo(preMeteo.icon),height: 32, width: 32,),
                title: Text(Meteo.getDisplayTime(preMeteo.time, localeTime), style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),  ),
                subtitle: Text(preMeteo.description, style: TextStyle(color: Colors.white),),
                trailing: Text("${preMeteo.temperature}${preMeteo.measure}", style: TextStyle(color: Colors.white ,fontSize: 25),),
              );                
            }
        ),
        const SizedBox(height: 30,),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayPrevisionsExtension.length,
            itemBuilder: (context, index){
              final preMeteoExtension = displayPrevisionsExtension[index];
              return ListTile(
                leading: Image.asset(Meteo.iconsForMeteo(preMeteoExtension.icon),height: 32, width: 32,),
                title: Text(Meteo.getDisplayTime(preMeteoExtension.time, localeTime), style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),  ),
                subtitle: Text(preMeteoExtension.description, style: TextStyle(color: Colors.white),),
                trailing: Text("${preMeteoExtension.temperature}${preMeteoExtension.measure}", style: TextStyle(color: Colors.white ,fontSize: 25),),
              );                
            }
        ),
      ],
    );
  }

}