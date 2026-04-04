import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../core/theme/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    try {
      AndroidInitializationSettings androidInitializationSettings =
          const AndroidInitializationSettings("@mipmap/ic_launcher");
      DarwinInitializationSettings darwinInitializationSettings =
          const DarwinInitializationSettings();

      InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings,
      );

      await flutterLocalNotificationsPlugin.initialize(
        settings: initializationSettings,
      );

      // Create notification channel for Android
      await _createNotificationChannel();

      await requestPermission();

      await _scheduleDailyNewsIfNeeded();
    } catch (e) {
      debugPrint("Error initializing notifications: $e");
    }
  }

  static Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'news_daily_channel', // id
      'News Updates', // title
      description: 'Daily news notifications', // description
      importance: Importance.max,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  static Future<bool> requestPermission() async {
    try {
      final bool? granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted ?? false;
    } catch (e) {
      debugPrint("Error requesting notification permission: $e");
      return false;
    }
  }

  static Future<void> rescheduleFromSavedLanguage() async {
    await flutterLocalNotificationsPlugin.cancel(id: 0);
    await _scheduleDailyNewsIfNeeded();
  }

  static Future<void> showTestNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('app_language') ?? 'en';
    final ar = lang == 'ar';

    final title = ar ? 'اختبار الإشعارات' : 'Notification Test';
    final body = ar ? 'هذا اختبار للإشعارات' : 'This is a test notification';

    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'news_daily_channel',
        'News Updates',
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
        //sound: RawResourceAndroidNotificationSound('sound'),
        enableVibration: true,
        playSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id: 999,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  static Future<void> _scheduleDailyNewsIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('notifications_enabled') ?? false;
    if (!enabled) return;

    final lang = prefs.getString('app_language') ?? 'en';
    final ar = lang == 'ar';

    final title = 'News Cloud';
    final body = ar ? 'توجد أخبار جديدة' : 'New news available';

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'news_daily_channel',
        ar ? 'تحديثات الأخبار' : 'News updates',
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
        color: AppStyle.originalPrimaryColor,
        //sound: RawResourceAndroidNotificationSound('sound'),
        enableVibration: true,
        playSound: true,
      ),
    );

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
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
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
