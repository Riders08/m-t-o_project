import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class CityResearch extends StatelessWidget {
  final Function(String) onSubmitted;

  const CityResearch({
    super.key,
    required this.onSubmitted
  });

  static const List<String> villes = [
    'Bordeaux',
    'Lille'
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (controller){
        if(controller.text.isEmpty){
          return const Iterable<String>.empty();
        }
        return villes.where(
          (city) => city.toLowerCase().contains(controller.text.toLowerCase()),
        ).take(4);
      },  
      onSelected: (String select){
        FocusScope.of(context).unfocus();
        onSubmitted(select);
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted){    
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
                              labelText: S.current.place, 
                              border: OutlineInputBorder()
          ),
          onSubmitted: (value){
            onSubmitted(value);
          }
        );
      },
    );
    
  }
}