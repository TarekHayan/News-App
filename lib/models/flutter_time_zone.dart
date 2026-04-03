import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class FlutterTimeZoneClass {
  static void init() {
    tz.initializeTimeZones();
  }

  static Future<void> setLocation() async {
    final location = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(location.identifier));
  }
}
