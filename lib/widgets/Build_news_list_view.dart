import 'package:flutter/material.dart';
import '../models/articalModel.dart';
import 'Design_news_list.dart';

class BuildNewsListView extends StatelessWidget {
  final List<Articalmodel> aricalModel;
  const BuildNewsListView({super.key, required this.aricalModel});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: aricalModel.length, (
        context,
        index,
      ) {
        return DesignNewsList(articalmodel: aricalModel[index]);
      }),
    );
  }
}
