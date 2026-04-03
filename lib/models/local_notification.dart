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

      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      await _scheduleDailyNewsIfNeeded();
    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }

  static Future<void> rescheduleFromSavedLanguage() async {
    await flutterLocalNotificationsPlugin.cancel(id: 0);
    await _scheduleDailyNewsIfNeeded();
  }

  static Future<void> _scheduleDailyNewsIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('notifications_enabled') ?? true;
    if (!enabled) return;

    final lang = prefs.getString('app_language') ?? 'en';
    final ar = lang == 'ar';

    final title = 'News Cloud';
    final body = ar ? 'توجد أخبار جديدة' : 'New news available';
    final channelName = ar ? 'تحديثات الأخبار' : 'News updates';

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'news_daily_channel',
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
        color: AppStyle.originalPrimaryColor,
        sound: RawResourceAndroidNotificationSound(
          'sound.mp3'.split('.').first,
        ),
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
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
