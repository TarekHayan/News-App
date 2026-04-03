import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/cubit/locale_cubit.dart';
import 'core/theme/app_theme.dart';
import 'models/flutter_time_zone.dart';
import 'models/local_notification.dart';
import 'views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localeCubit = await LocaleCubit.create();

  runApp(
    BlocProvider<LocaleCubit>.value(value: localeCubit, child: const MyApp()),
  );

  _initServices();
}

Future<void> _initServices() async {
  try {
    // 1. تهيئة المناطق الزمنية أولاً (ضرورية لجدولة الإشعارات)
    FlutterTimeZoneClass.init();
    await FlutterTimeZoneClass.setLocation();

    // 2. تهيئة الإشعارات (تعتمد على الوقت المحلي)
    await FlutterLocalNotification.init();
  } catch (e) {
    debugPrint("Initialization error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, String>(
      builder: (context, lang) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: const CustomScrollBehavior(),
          theme: AppTheme.materialTheme(),
          locale: Locale(lang),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SplashScreen(),
        );
      },
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
