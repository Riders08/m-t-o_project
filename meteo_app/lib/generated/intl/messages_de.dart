// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Wetter"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "Du hast keine Berechtigung erteilt, auf deinen Standort zuzugreifen.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Schwerwiegender Fehler"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage(
      "Stadt nicht gefunden",
    ),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Abrufen der API-Daten!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Fehler beim Abrufen deines Standorts",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "Das Abrufen deines Standorts hat zu lange gedauert",
    ),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Standort konnte nicht ermittelt werden",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "Dein Standort ist deaktiviert",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Standortberechtigung dauerhaft verweigert.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("Stadt/Land"),
  };
}
