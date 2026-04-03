import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'article_list_item.dart';

class NewsFeedItems extends StatelessWidget {
  const NewsFeedItems({super.key, required this.articles});

  final List<ArticleModel> articles;

  static const double _wideLayoutBreakpoint = 700;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < _wideLayoutBreakpoint) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ArticleListItem(article: articles[index]),
          childCount: articles.length,
        ),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => ArticleListItem(article: articles[index]),
        childCount: articles.length,
      ),
    );
  }
}
