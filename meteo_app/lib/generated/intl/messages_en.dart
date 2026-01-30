// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Weather"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "You did not grant permission to access your location.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Major error"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage("City not found"),
    "feels_like": MessageLookupByLibrary.simpleMessage("Feels like"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "Failed to retrieve data from the API!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Error while retrieving your location",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "Retrieving your location took too long",
    ),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Unable to get your location",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "Your location is disabled",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Location permission permanently denied.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("City/Country"),
    "previsions": MessageLookupByLibrary.simpleMessage("5-day forecast"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "wallpaper": MessageLookupByLibrary.simpleMessage("Wallpaper"),
  };
}
