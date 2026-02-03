// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("날씨"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "위치 정보 접근 권한이 허용되지 않았습니다.",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("심각한 오류"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage("도시를 찾을 수 없습니다"),
    "feels_like": MessageLookupByLibrary.simpleMessage("체감온도"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "API에서 데이터를 가져오지 못했습니다!",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "위치 정보를 가져오는 중 오류가 발생했습니다",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "위치 정보를 가져오는 데 시간이 너무 오래 걸렸습니다",
    ),
    "history": MessageLookupByLibrary.simpleMessage("기록"),
    "home": MessageLookupByLibrary.simpleMessage("홈"),
    "language": MessageLookupByLibrary.simpleMessage("언어"),
    "locationError": MessageLookupByLibrary.simpleMessage("현재 위치를 가져올 수 없습니다"),
    "locationNotActive": MessageLookupByLibrary.simpleMessage(
      "위치 정보가 비활성화되어 있습니다",
    ),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "위치 정보 권한이 영구적으로 거부되었습니다.",
    ),
    "place": MessageLookupByLibrary.simpleMessage("도시/국가"),
    "previsions": MessageLookupByLibrary.simpleMessage("5일 예보"),
    "settings": MessageLookupByLibrary.simpleMessage("설정"),
    "theme": MessageLookupByLibrary.simpleMessage("테마"),
    "wallpaper": MessageLookupByLibrary.simpleMessage("배경화면"),
  };
}
