import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articalModel.dart';
import 'package:news_app/tools/circle_loadind.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:news_app/models/news_data.dart';

class DesignNewsList extends StatelessWidget {
  const DesignNewsList({super.key, required this.articalmodel});
  final Articalmodel articalmodel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: CachedNetworkImage(
              imageUrl: articalmodel.checkImage(),
              placeholder: (context, url) =>
                  Center(child: CircleLoadind(color: Color(0xffcbff56))),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/Event-Image-Not-Found.jpg"),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(
            articalmodel.checkTitle(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xffcbff56),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            articalmodel.checkdes(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Text(
              'Read More',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),
            onTap: () async {
              final Uri url = Uri.parse(articalmodel.checkurl());

              await launchUrl(url, mode: LaunchMode.inAppWebView);
            },
          ),
        ),
      ],
    );
  }
}
