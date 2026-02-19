import 'package:flutter/material.dart';
import 'package:meteo_app/models/models.dart';
import '../generated/l10n.dart';


class HistoryPage extends StatelessWidget {
  final Meteo meteo;
  final List<SearchHistory> listResearch;
  final Function(SearchHistory) onTap;
  const HistoryPage({
      super.key,
      required this.meteo,
      required this.listResearch,
      required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${S.current.actuallyPosition}: ${meteo.location}', style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 30),
            LayoutBuilder(builder: (builder, contraint){
              return Container(
                color: Colors.black,height: 1,width: contraint.maxWidth,
              );
            })
          ],
        )
      );
  }
}