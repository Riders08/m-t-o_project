import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class CityResearch extends StatelessWidget {
  final Function(String) onSubmitted;

  const CityResearch({
    super.key,
    required this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
                          labelText: S.current.place, 
                          border: OutlineInputBorder()
      ),
      onSubmitted: onSubmitted
    );
  }
}