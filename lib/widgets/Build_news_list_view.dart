//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articalModel.dart';
import 'package:news_app/widgets/Design_news_list.dart';
//import 'package:news_app/models/news_data.dart';
//import 'package:news_app/service/getNewsData.dart';
//import 'package:news_app/widgets/news_list.dart';

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
