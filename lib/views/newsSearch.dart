import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'newsSearchPadge.dart';
import '../widgets/network_error.dart';
import '../core/utils/app_styles.dart';

class Newssearch extends StatelessWidget {
  const Newssearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Discover',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find news from all over the world',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
            ),
            const SizedBox(height: 40),
            TextField(
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return OfflineBuilder(
                          connectivityBuilder:
                              (
                                BuildContext context,
                                List<ConnectivityResult> connectivity,
                                Widget child,
                              ) {
                                final bool connected = !connectivity.contains(
                                  ConnectivityResult.none,
                                );
                                return connected
                                    ? Newssearchpadge(valu: value)
                                    : NetworkError();
                              },
                          child: Container(),
                        );
                      },
                    ),
                  );
                }
              },
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              cursorColor: AppStyle.originalPrimaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Icon(
                    Icons.search,
                    color: AppStyle.originalPrimaryColor,
                    size: 26,
                  ),
                ),
                hintText: 'Keywords, topics, or sources...',
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppStyle.originalPrimaryColor,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Icon(
                Icons.travel_explore,
                size: 100,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
