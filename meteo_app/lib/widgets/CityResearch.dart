import 'package:flutter/material.dart';

class CityResearch extends StatelessWidget {
  final Function(String) onSubmitted;

  const CityResearch({
    super.key,
    required this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
                          labelText: "Ville/Pays", 
                          border: OutlineInputBorder()
      ),
      onSubmitted: onSubmitted
    );
  }
}