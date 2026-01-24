// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Pogoda"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "Nie udzielono pozwolenia na dostęp do lokalizacji.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Poważny błąd"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage(
      "Nie znaleziono miasta",
    ),
    "feels_like": MessageLookupByLibrary.simpleMessage("Odczuwalna"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "Nie udało się pobrać danych z API!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Błąd podczas pobierania lokalizacji",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "Pobranie Twojej lokalizacji zajęło za dużo czasu",
    ),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Nie można pobrać Twojej lokalizacji",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "Twoja lokalizacja jest wyłączona",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Pozwolenie na lokalizację zostało trwale odrzucone.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("Miasto/Kraj"),
    "previsions": MessageLookupByLibrary.simpleMessage("Prognoza na 5 dni"),
  };
}
