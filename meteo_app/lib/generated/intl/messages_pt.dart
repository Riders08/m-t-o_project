// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Clima"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "Você não concedeu permissão para acessar sua localização.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Erro grave"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage(
      "Cidade não encontrada",
    ),
    "feels_like": MessageLookupByLibrary.simpleMessage("Sensação"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "Falha ao recuperar dados da API!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Erro ao recuperar sua localização",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "A recuperação da sua localização demorou muito",
    ),
    "history": MessageLookupByLibrary.simpleMessage("Histórico"),
    "language": MessageLookupByLibrary.simpleMessage("Língua"),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Não foi possível obter sua localização",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "Sua localização está desativada",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Permissão de localização negada permanentemente.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("Cidade/País"),
    "previsions": MessageLookupByLibrary.simpleMessage("Previsão para 5 dias"),
    "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "wallpaper": MessageLookupByLibrary.simpleMessage("Papel de parede"),
  };
}
