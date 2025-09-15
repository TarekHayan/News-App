import 'package:flutter/material.dart';
import 'package:news_app/service/getNewsData.dart';
import 'package:news_app/widgets/viewNews.dart';

class CategryNews extends StatelessWidget {
  const CategryNews({super.key, required this.categry});
  final String categry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          ViewNews(
            typeNews: Getnewsservice().getheadlines(categry: categry),
            categry: categry,
          ),
        ],
      ),
    );
  }
}
