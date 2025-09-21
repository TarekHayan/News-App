import 'package:flutter/material.dart';
import 'package:news_app/views/HomePadge.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد 3 ثواني يروح للصفحة الرئيسية
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePadge()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // الخلفية
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // اللوجو
            Image.asset(
              "assets/playstore.png", // حط صورتك هنا
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 5),
            // الاسم
            Text(
              "News Cloud", // اسمك
              style: TextStyle(
                color: Color(0xffcbff56), // اللون الفسفوري
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),
            Text(
              "By : Tarek Hayan", // اسمك
              style: TextStyle(
                color: Colors.white.withOpacity(0.4), // اللون الفسفوري
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
