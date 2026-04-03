import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/theme/app_styles.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocaleCubit>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              color: AppStyle.originalPrimaryColor,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              loc.tn('No internet connection', 'لا يوجد اتصال بالإنترنت'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              loc.tn(
                'Please check your connection.',
                'تحقق من الاتصال وحاول مرة أخرى.',
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
