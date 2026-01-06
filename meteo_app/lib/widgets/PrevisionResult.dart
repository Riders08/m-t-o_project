import 'package:flutter/material.dart';
import 'package:meteo_app/models/prevision.dart';
import 'package:meteo_app/models/meteo.dart';


class PrevisionResult extends StatelessWidget{
  final Prevision prevision;

  const PrevisionResult({
    super.key,
    required this.prevision
  });

  @override
  Widget build(BuildContext context) {
    final localeTime = Localizations.localeOf(context).toString();
    return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: prevision.previsions.length,
              itemBuilder: (context, index){
                final preMeteo = prevision.previsions[index];
                return ListTile(
                  leading: Image.asset(Meteo.iconsForMeteo(preMeteo.icon),height: 32, width: 32,),
                  title: Text(Meteo.getDisplayTime(preMeteo.time, localeTime), style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(preMeteo.description),
                  trailing: Text("${preMeteo.temperature}${preMeteo.measure}", style: TextStyle(fontSize: 25),),
                );
              }
        
    );
  }

}