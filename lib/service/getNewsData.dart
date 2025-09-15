import 'package:dio/dio.dart';
import 'package:news_app/models/articalModel.dart';

class Getnewsservice {
  final Dio dio = Dio();
  Getnewsservice();
  String apiKey = '1acb0c680dc8465085d2f5a0f6bcb0d6&category';
  Future<List<Articalmodel>> getheadlines({required String categry}) async {
    try {
      var response = await dio.get(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey=$categry",
      );
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData['articles'];
      List<Articalmodel> listArticals = [];

      for (var artical in articles) {
        Articalmodel articalmodel = Articalmodel.fromJason(artical);
        listArticals.add(articalmodel);
      }
      return (listArticals);
    } catch (e) {
      return [];
    }
  }

  //----------------------------------------------------------------------------
  Future<List<Articalmodel>> getSearch({required String name}) async {
    try {
      var response = await dio.get(
        "https://newsapi.org/v2/everything?q=$name&apiKey=$apiKey",
      );
      Map<String, dynamic> jasonData2 = response.data;
      List<dynamic> artical2 = jasonData2['articles'];
      List<Articalmodel> listArticals_2 = [];

      for (var artical in artical2) {
        Articalmodel articalmodel = Articalmodel.fromJason(artical);
        listArticals_2.add(articalmodel);
      }
      return (listArticals_2);
    } catch (e) {
      return [];
    }
  }
}
