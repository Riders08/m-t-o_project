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

  Future<void> DailyNotification({required int hour,
                                  required int minutes,
                                  required String title,
                                  required String body
                                }) async {
    final now = tz.TZDateTime.now(tz.local);// Recuperation de l'heure et son ensemble via la localisation
    var time = tz.TZDateTime(tz.local,now.year,now.month,now.day,hour, minutes, now.second,now.millisecond,now.microsecond); // Recupération exacte de l'heure et la date

    if(time.isBefore(now)){ // check si l'heure que l'on a recupérer est passé ou non 
      time = time.add(const Duration(days: 1)); // si passé on reporte à demain
    }

    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'daily_chanel',
      'daily_Notification',
      channelDescription: 'Notification du jour',
      importance: Importance.max,
      priority: Priority.high
    );// Définition de la notification

    await _notificationsPlugin.cancel(0);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    
    await _notificationsPlugin.periodicallyShow(0,title,body,RepeatInterval.daily,notificationDetails,androidAllowWhileIdle: true);

  } 

}