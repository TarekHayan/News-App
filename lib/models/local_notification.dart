import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:news_app/core/utils/app_styles.dart';
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 1",
        "News apdated",
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
        color: AppStyle.originalPrimaryColor,
        sound: RawResourceAndroidNotificationSound(
          "sound.mp3".split('.').first,
        ),
      ),
    );

    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      10,
      0,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: 0,
      title: "News App",
      body: "New News Available",
      scheduledDate: scheduledDate,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
