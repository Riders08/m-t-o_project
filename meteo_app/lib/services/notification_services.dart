import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initNotif() async{
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher'); 
    const InitializationSettings settings = InitializationSettings(android: androidSetting);

    await _notificationsPlugin.initialize(settings);
  }

  Future<void> DailyNotification({required int hour,
                                  required int minutes,
                                  required String title,
                                  required String body
                                }) async {
    
    return null;
  } 
}