import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/theme/app_styles.dart';
import '../services/news_api_service.dart';
import 'news_search_screen.dart';
import 'settings_page.dart';
import '../widgets/category_carousel.dart';
import '../widgets/network_error.dart';
import '../widgets/news_feed_sliver.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const NewsSearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              children: [
                TextSpan(
                  text: 'News',
                  style: const TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Cloud',
                  style: const TextStyle(color: AppStyle.originalPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext context, List<ConnectivityResult> connectivity, _) {
              final connected = !connectivity.contains(ConnectivityResult.none);
              if (connected) {
                return const _HomeHeadlinesBody();
              }
              return const NetworkError();
            },
        child: const SizedBox.shrink(),
      ),
    );
  }
}

class _HomeHeadlinesBody extends StatelessWidget {
  const _HomeHeadlinesBody();

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>();
    final api = NewsApiService();

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: CategoryCarousel()),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                locale.tn('Top Headlines', 'أهم العناوين'),
                style: const TextStyle(
                  color: AppStyle.originalPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        NewsFeedSliver(newsFuture: api.fetchTopHeadlines(category: 'general')),
      ],
    );
  }
}
