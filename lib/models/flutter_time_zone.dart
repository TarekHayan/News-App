import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class FlutterTimeZoneClass {
  static void init() {
    tz.initializeTimeZones();
  }

  static Future<void> setLocation() async {
    try {
      final location = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(location.identifier));
    } catch (e) {
      // Fallback or just ignore if it fails
      print("Error setting timezone: $e");
    }
  }
}
