import 'package:flutter/material.dart';
import '../service/getNewsData.dart';
import '../widgets/viewNews.dart';
import '../utils/app_styles.dart';

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
          style: TextStyle(color: AppStyle.originalPrimaryColor),
        ),
        centerTitle: true,
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
