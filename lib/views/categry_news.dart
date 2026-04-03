import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:news_app/core/utils/app_styles.dart';
import '../widgets/network_error.dart';
import '../service/getNewsData.dart';
import '../widgets/viewNews.dart';

class CategryNews extends StatelessWidget {
  const CategryNews({super.key, required this.categry});
  final String categry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categry.toUpperCase(),
          style: TextStyle(
            color: AppStyle.originalPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );
              if (connected) {
                return ShowCategryNews(categry: categry);
              } else {
                return NetworkError();
              }
            },
        child: Container(),
      ),
    );
  }
}

class ShowCategryNews extends StatelessWidget {
  const ShowCategryNews({super.key, required this.categry});

  final String categry;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ViewNews(
          typeNews: Getnewsservice().getheadlines(categry: categry),
          categry: categry,
        ),
      ],
    );
  }
}
