import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initNotif() async{
    tz.initializeTimeZones(); // Ici je recupère littéralement la date et heures exacte 

    const AndroidInitializationSettings androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher'); 
    const InitializationSettings settings = InitializationSettings(android: androidSetting);

    await _notificationsPlugin.initialize(settings);

    final androidPlugin = _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
  }

  Future<void> DailyNotification({
    required int hour,
    required int minutes,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    /*const androidDetails = AndroidNotificationDetails(
      'daily_channel',
      'Daily notifications',
      channelDescription: 'Notification météo quotidienne',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails =
        NotificationDetails(android: androidDetails);*/

    await _notificationsPlugin.periodicallyShow(
      3,
      'Météo quotidienne',
      'Attention le temps chute actuellement',
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Notifications répétitives',
          channelDescription: 'Notification météo quotidienne',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
    );
  }
}