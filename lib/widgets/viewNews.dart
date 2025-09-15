//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/errors/requestError.dart';
import 'package:news_app/models/articalModel.dart';
//import 'package:news_app/models/articalModel.dart';
//import 'package:news_app/service/getNewsData.dart';
import 'package:news_app/tools/circle_loadind.dart';
import 'package:news_app/widgets/Build_news_list_view.dart';

class ViewNews extends StatefulWidget {
  const ViewNews({super.key, required this.categry, required this.typeNews});
  final String categry;
  final dynamic typeNews;
  @override
  State<ViewNews> createState() => _ViewNewsState();
}

class _ViewNewsState extends State<ViewNews> {
  var futur;
  @override
  void initState() {
    super.initState();
    futur = widget.typeNews;
    // futur = Getnewsservice().getheadlines(categry: widget.categry);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Articalmodel>>(
      future: futur,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(child: CircleLoadind(color: Colors.blue)),
          );
        }
        if (snapshot.hasError) {
          return ErrorInRequest(
            errorMassage: 'Something went wrong try again later',
          );
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return ErrorInRequest(
            errorMassage: 'No news available at the moment',
          );
        }
        return BuildNewsListView(aricalModel: snapshot.data!);
      },
    );

    // return isLoding
    //     ? SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
    //     : aricalModel.isNotEmpty
    //     ? NewsListView(aricalModel: aricalModel)
    //     : SllliverFiRemaining(
    //         child: Center(
    //           child: Text(
    //             "server is under maintenance",
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //       );
  }
}
