import 'package:flutter/material.dart';
import 'package:news_app/service/getNewsData.dart';
import 'package:news_app/widgets/viewNews.dart';

class Newssearchpadge extends StatelessWidget {
  const Newssearchpadge({super.key, required this.valu});
  final String valu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          valu.toUpperCase(),
          style: TextStyle(color: Color(0xffe1ff49)),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          ViewNews(
            categry: valu,
            typeNews: Getnewsservice().getSearch(name: valu),
          ),
        ],
      ),
    );
  }
}
