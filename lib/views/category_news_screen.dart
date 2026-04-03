import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/localization/localized_strings.dart';
import '../core/theme/app_styles.dart';
import '../services/news_api_service.dart';
import '../widgets/network_error.dart';
import '../widgets/news_feed_sliver.dart';

class CategoryNewsScreen extends StatelessWidget {
  const CategoryNewsScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>();
    final label = localizedCategoryLabel(locale, category);
    final titleText = locale.isArabic ? label : label.toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleText,
          style: const TextStyle(
            color: AppStyle.originalPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (BuildContext context, List<ConnectivityResult> connectivity, _) {
              final connected = !connectivity.contains(ConnectivityResult.none);
              if (connected) {
                return _CategoryNewsBody(category: category);
              }
              return const NetworkError();
            },
        child: const SizedBox.shrink(),
      ),
    );
  }
}

class _CategoryNewsBody extends StatelessWidget {
  const _CategoryNewsBody({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final api = NewsApiService();
    return CustomScrollView(
      slivers: [
        NewsFeedSliver(newsFuture: api.fetchTopHeadlines(category: category)),
      ],
    );
  }
}
