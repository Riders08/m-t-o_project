// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("天気"),
    "autoriwedLocationError": MessageLookupByLibrary.simpleMessage(
      "位置情報へのアクセス権限が許可されていません。",
    ),
    "bigError": MessageLookupByLibrary.simpleMessage("重大なエラー"),
    "cityNotFound": MessageLookupByLibrary.simpleMessage("都市が見つかりません"),
    "feels_like": MessageLookupByLibrary.simpleMessage("体感温度"),
    "getDataAPIError": MessageLookupByLibrary.simpleMessage(
      "API からデータを取得できませんでした。",
    ),
    "getLocationError": MessageLookupByLibrary.simpleMessage(
      "位置情報の取得中にエラーが発生しました",
    ),
    "getLocationTimeError": MessageLookupByLibrary.simpleMessage(
      "位置情報の取得に時間がかかりすぎました",
    ),
    "history": MessageLookupByLibrary.simpleMessage("履歴"),
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "locationError": MessageLookupByLibrary.simpleMessage("現在地を取得できません"),
    "locationNotActive": MessageLookupByLibrary.simpleMessage("位置情報が無効になっています"),
    "permissionLocationError": MessageLookupByLibrary.simpleMessage(
      "位置情報の権限が永久に拒否されました。",
    ),
    "place": MessageLookupByLibrary.simpleMessage("都市／国"),
    "previsions": MessageLookupByLibrary.simpleMessage("5日間予報"),
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "wallpaper": MessageLookupByLibrary.simpleMessage("壁紙"),
  };
}
