// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Météo"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez pas donnée l\'autorisation à avoir accès à votre localisation.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Erreur énorme"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage("Ville introuvable"),
    "feels_like": MessageLookupByLibrary.simpleMessage("Ressentie"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "La récupération des données de l\'API a échouée !",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Erreur lors de la récupération de votre localisation",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "La récupération de votre localisation à mis trop de temps",
    ),
    "history": MessageLookupByLibrary.simpleMessage("Historique"),
    "home": MessageLookupByLibrary.simpleMessage("Acceuil"),
    "language": MessageLookupByLibrary.simpleMessage("Langue"),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'obtenir votre position",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "Votre localisation est désactivé",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Permission de récupération de localisation refusée définitivement.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("Ville/Pays"),
    "previsions": MessageLookupByLibrary.simpleMessage("Prévision sur 5 jours"),
    "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "theme": MessageLookupByLibrary.simpleMessage("Thème"),
    "wallpaper": MessageLookupByLibrary.simpleMessage("Fond d\'écran"),
  };
}
