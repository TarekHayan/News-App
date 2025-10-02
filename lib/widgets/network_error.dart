import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة توضح ان مفيش نت
            Icon(Icons.wifi_off, color: Color(0xffcbff56), size: 80),
            const SizedBox(height: 20),

            // عنوان الرسالة
            Text(
              'No Internet Connection',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // وصف قصير
            Text(
              'Please check your connection.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
