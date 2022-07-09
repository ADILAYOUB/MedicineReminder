import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  BuildContext? _context;

  Future<FlutterLocalNotificationsPlugin> initNotifies(
      BuildContext context) async {
    _context = context;
    //-----------------------------| Inicialize local notifications |--------------------------------------
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    return flutterLocalNotificationsPlugin;
    //======================================================================================================
  }

  //---------------------------------| Show the notification in the specific time |-------------------------------
  Future showNotification(String title, String description, int time, int id,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.toInt(),
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: time)),
        const NotificationDetails(
            android: AndroidNotificationDetails('medicines_id', 'medicines',
                channelDescription: 'medicines_notification_channel',
                importance: Importance.high,
                priority: Priority.high,
                color: Colors.cyanAccent)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  //================================================================================================================

  //-------------------------| Cancel the notify |---------------------------
  Future removeNotify(int notifyId,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      return await flutterLocalNotificationsPlugin.cancel(notifyId);
    } catch (e) {
      return null;
    }
  }

  //==========================================================================

  //-------------| function to inicialize local notifications |---------------------------
  Future onSelectNotification(String? payload) async {
    showDialog(
      context: _context!,
      builder: (_) {
        return AlertDialog(
          title: const Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
//======================================================================================

}
