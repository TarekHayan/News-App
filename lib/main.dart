import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:news_app/models/flutter_time_zone.dart';
import 'package:news_app/models/local_notification.dart';
import 'views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterTimeZoneClass.init();
  await FlutterTimeZoneClass.setLocation();
  await FlutterLocalNotification.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      home: SplashScreen(),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
