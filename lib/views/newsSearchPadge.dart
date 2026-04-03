import 'package:flutter/material.dart';
import '../service/getNewsData.dart';
import '../widgets/viewNews.dart';
import '../core/utils/app_styles.dart';

class Newssearchpadge extends StatelessWidget {
  const Newssearchpadge({super.key, required this.valu});
  final String valu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          valu.toUpperCase(),
          style: TextStyle(color: AppStyle.originalPrimaryColor),
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
