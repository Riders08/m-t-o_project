// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Погода"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "Вы не предоставили разрешение на доступ к вашему местоположению.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("Серьезная ошибка"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage("Город не найден"),
    "feels_like": MessageLookupByLibrary.simpleMessage("Ощущается как"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить данные с API!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "Ошибка при получении вашего местоположения",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "Получение вашего местоположения заняло слишком много времени",
    ),
    "history": MessageLookupByLibrary.simpleMessage("История"),
    "home": MessageLookupByLibrary.simpleMessage("Главная"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "locationError": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить ваше местоположение",
    ),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "Ваше местоположение отключено",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "Разрешение на доступ к местоположению было окончательно отклонено.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("Город/Страна"),
    "previsions": MessageLookupByLibrary.simpleMessage("Прогноз на 5 дней"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "wallpaper": MessageLookupByLibrary.simpleMessage("Обои"),
  };
}
