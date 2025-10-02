import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../service/getNewsData.dart';
import 'newsSearch.dart';
import '../widgets/categery_list_veiw.dart';
import '../widgets/network_error.dart';
import '../widgets/viewNews.dart';

class HomePadge extends StatelessWidget {
  const HomePadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Newssearch();
                  },
                ),
              );
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 35),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "News",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  TextSpan(
                    text: "Cloud",
                    style: TextStyle(
                      color: Color(0xffe1ff49),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );
              if (connected) {
                return ShowHeadlinesNews();
              } else {
                return NetworkError();
              }
            },
        child: Container(),
      ),
    );
  }
}

class ShowHeadlinesNews extends StatelessWidget {
  const ShowHeadlinesNews({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: CategeryListVeiw()),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Top Headlines',
                style: TextStyle(
                  color: Color(0xffe1ff49),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
        ViewNews(
          typeNews: Getnewsservice().getheadlines(categry: 'general'),
          categry: 'general',
        ),
      ],
    );
  }
}
