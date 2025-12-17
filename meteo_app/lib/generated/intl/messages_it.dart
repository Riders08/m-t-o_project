// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Meteo"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "Non hai concesso l\'autorizzazione per accedere alla tua posizione.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Errore grave"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage("Città non trovata"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "Impossibile recuperare i dati dall\'API!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Errore durante il recupero della tua posizione",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "Il recupero della tua posizione ha richiesto troppo tempo",
    ),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Impossibile ottenere la tua posizione",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "La tua posizione è disattivata",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Autorizzazione alla posizione negata in modo permanente.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("Città/Paese"),
  };
}
