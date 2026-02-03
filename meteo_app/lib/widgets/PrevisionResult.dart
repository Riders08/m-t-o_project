import 'package:flutter/material.dart';
import 'package:meteo_app/models/prevision.dart';
import 'package:meteo_app/models/meteo.dart';
import 'package:meteo_app/widgets/PressIcon.dart';

import 'dart:ui';
import '../generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrevisionResult extends StatefulWidget{
  final Meteo meteo;
  final Prevision prevision;

  const PrevisionResult({
    super.key,
    required this.meteo,
    required this.prevision,
  });

  @override
  State<PrevisionResult> createState() => _PrevisionResultState();

}

class _PrevisionResultState extends State<PrevisionResult> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final localeTime = Localizations.localeOf(context).toString();
    final today = widget.meteo.time;
    final tomorrow = Meteo.nextDay(today);

    final List<Meteo> previsionsToday =widget.prevision.previsions.where((pre) => Meteo.sameDay(today, pre.time)).toList();
    final List<Meteo> previsionsTomorrow = widget.prevision.previsions.where((preT) => Meteo.sameDay(tomorrow, preT.time)).toList();

    final displayPrevisions = previsionsToday.isNotEmpty ? previsionsToday : previsionsTomorrow; 

    final List<Meteo> displayPrevisionsExtension = widget.prevision.previsions.where((preExt) => Meteo.isAfter(preExt.time, displayPrevisions.last.time)).toList();
    

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
        Center(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16.0),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), 
                  child: Card(
                      color: Color.fromARGB(26, 255, 255, 255),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.current.previsions, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                                PressIcon(
                                  icon: FontAwesomeIcons.caretRight ,
                                  open: _isOpen,
                                  onTap: () async {
                                    setState(() {
                                      _isOpen = !_isOpen;
                                    });
                                  }
                                ),   
                              ],
                            ),
                            if(_isOpen)...[ // le ...[] est forcée due au Sizebox 
                              const SizedBox(height: 6,),
                              Container(width: 300, height: 1, color: Colors.white,),
                              const SizedBox(height: 6,),
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
                            ),]
                          ],
                        )  
                      ),
                ),
              ),
            )
          ),
          const SizedBox(height: 30,),
          
      ],
    );
  }
}