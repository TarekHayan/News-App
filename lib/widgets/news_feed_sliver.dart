import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/theme/app_styles.dart';
import '../core/widgets/circle_loading.dart';
import '../core/widgets/request_error_sliver.dart';
import '../models/article_model.dart';
import 'news_feed_items.dart';

class NewsFeedSliver extends StatefulWidget {
  const NewsFeedSliver({super.key, required this.newsFuture});

  final Future<List<ArticleModel>> newsFuture;

  @override
  State<NewsFeedSliver> createState() => _NewsFeedSliverState();
}

class _NewsFeedSliverState extends State<NewsFeedSliver> {
  late final Future<List<ArticleModel>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = widget.newsFuture;
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocaleCubit>();

    return FutureBuilder<List<ArticleModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(
              child: CircleLoading(color: AppStyle.originalPrimaryColor),
            ),
          );
        }
        if (snapshot.hasError) {
          return RequestErrorSliver(
            message: loc.tn(
              'Something went wrong. Try again later.',
              'حدث خطأ. حاول مرة أخرى لاحقًا.',
            ),
          );
        }
        final data = snapshot.data;
        if (data == null || data.isEmpty) {
          return RequestErrorSliver(
            message: loc.tn(
              'No news available at the moment.',
              'لا توجد أخبار حاليًا.',
            ),
          );
        }
        return NewsFeedItems(articles: data);
      },
    );
  }
}
