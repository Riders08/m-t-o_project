// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Weer"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "Je hebt geen toestemming gegeven om toegang te krijgen tot je locatie.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Grote fout"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage("Stad niet gevonden"),
    "feels_like": MessageLookupByLibrary.simpleMessage("Gevoeld"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "Het ophalen van gegevens van de API is mislukt!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Fout bij het ophalen van je locatie",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "Het ophalen van je locatie heeft te lang geduurd",
    ),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Kan je locatie niet ophalen",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "Je locatie is uitgeschakeld",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Locatietoestemming permanent geweigerd.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("Stad/Land"),
    "previsions": MessageLookupByLibrary.simpleMessage("5-daagse voorspelling"),
  };
}
