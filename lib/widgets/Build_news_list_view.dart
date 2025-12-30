import 'package:flutter/material.dart';
import '../models/articalModel.dart';
import 'Design_news_list.dart';

class BuildNewsListView extends StatelessWidget {
  final List<Articalmodel> aricalModel;
  const BuildNewsListView({super.key, required this.aricalModel});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 700) {
      // Mobile Layout: List View
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return DesignNewsList(articalmodel: aricalModel[index]);
          },
          childCount: aricalModel.length,
        ),
      );
    } else {
      // Tablet/Desktop Layout: Grid View
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300, // Maximum width of each item
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.7, // Adjust ratio as needed for card content
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return DesignNewsList(articalmodel: aricalModel[index]);
          },
          childCount: aricalModel.length,
        ),
      );
    }
  }
}
