import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/views/HomePadge.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // هنا تروح للصفحة الرئيسية بعد السبلاتش
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePadge()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة البرنامج
            Image.asset(
              'assets/1024.png', // ضع صورة الأيقونة هنا في مجلد assets
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 30),

            // اسم التطبيق
            Text(
              "News App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent.shade400, // فسفوري
              ),
            ),
            const SizedBox(height: 10),

            // اسم المطور
            Text(
              "Developed by Tarek Hayan",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
