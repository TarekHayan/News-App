import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/theme/app_styles.dart';
import '../core/widgets/circle_loading.dart';
import '../core/widgets/translated_text.dart';
import '../models/article_model.dart';
import '../views/article_detail_screen.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LocaleCubit>();
    final isArabic = cubit.isArabic;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (context) => ArticleDetailScreen(article: article),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: isArabic
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // ── Image ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrlOrFallback(),
                    placeholder: (context, url) => Center(
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        colors: const [AppStyle.originalPrimaryColor],
                        strokeWidth: 1,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/Event-Image-Not-Found.jpg',
                      fit: BoxFit.cover,
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // ── Title ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: TranslatedText(
                text: article.titleOrFallback(),
                localeCubit: cubit,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppStyle.originalPrimaryColor,
                ),
                maxLines: 2,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),

            // ── Description ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(bottom: 18, left: 15, right: 15),
              child: TranslatedText(
                text: article.descriptionOrFallback(),
                localeCubit: cubit,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 3,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
