import 'package:flutter/material.dart';
import 'package:meteo_app/services/cityResearch_services.dart';
import 'package:meteo_app/models/cityResearch.dart';

import '../generated/l10n.dart';

class CityResearchWidgets extends StatefulWidget {
  final CityResearchServices cityResearchServices;
  final Function(CityResearch city) onSubmitted;

  const CityResearchWidgets({
    super.key,
    required this.cityResearchServices,
    required this.onSubmitted,
  });

  @override
  State<CityResearchWidgets> createState() => _CityResearchState();
}

class _CityResearchState extends State<CityResearchWidgets>{
  @override
  Widget build(BuildContext context) {
    return Autocomplete<CityResearch>(
      displayStringForOption: (ville) => ville.displayName,
      optionsBuilder: (TextEditingValue controller) async{
        if(controller.text.isEmpty || controller.text.length < 2){
          return [];
        }
        return (await widget.cityResearchServices.searchCities(controller.text)).where(
          (city) => city.displayName.toLowerCase().contains(controller.text.toLowerCase()),
        ).take(4);
      },  
      onSelected: (ville){
        FocusScope.of(context).unfocus();
        widget.onSubmitted(ville);
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted){    
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
                              labelText: S.current.place, 
                              border: OutlineInputBorder()
          ),
        );
      },
    );
    
  }
}