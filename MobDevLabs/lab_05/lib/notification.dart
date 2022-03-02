import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//Создание класса уведомления
class Notifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
     FlutterLocalNotificationsPlugin();
//Инициализация уведомления ( описано только для платформы Android)
  void initNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
         );
  }
//Вызов уведомления с параметрами заголовка и тела уведомления
  Future<void> pushNotification({required String title,required String body }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'push_messages: 0', 'push_messages: push_messages', channelDescription: 'push_messages: A new Flutter project',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        enableVibration: true,
      );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'item x');
  }
}