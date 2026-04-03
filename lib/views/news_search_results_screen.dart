import 'package:flutter/material.dart';
import '../core/theme/app_styles.dart';
import '../services/news_api_service.dart';
import '../widgets/news_feed_sliver.dart';

class NewsSearchResultsScreen extends StatelessWidget {
  const NewsSearchResultsScreen({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final api = NewsApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          query.toUpperCase(),
          style: const TextStyle(color: AppStyle.originalPrimaryColor),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          NewsFeedSliver(newsFuture: api.searchEverything(query: query)),
        ],
      ),
    );
  }
}
