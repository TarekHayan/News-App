import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/articalModel.dart';
import '../core/tools/circle_loadind.dart';
import '../core/utils/app_styles.dart';

class DesignNewsList extends StatelessWidget {
  const DesignNewsList({super.key, required this.articalmodel});
  final Articalmodel articalmodel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: articalmodel.checkImage(),
                placeholder: (context, url) => Center(
                  child: CircleLoadind(color: AppStyle.originalPrimaryColor),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/Event-Image-Not-Found.jpg",
                  fit: BoxFit.cover,
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(
            articalmodel.checkTitle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppStyle.originalPrimaryColor,
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
