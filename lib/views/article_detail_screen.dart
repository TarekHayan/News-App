import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/theme/app_styles.dart';
import '../core/widgets/circle_loading.dart';
import '../core/widgets/translated_text.dart';
import '../models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LocaleCubit>();
    final isArabic = cubit.isArabic;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _SliverHeader(article: article),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  // ── Source Badge ─────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppStyle.originalPrimaryColor.withValues(
                        alpha: 0.15,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppStyle.originalPrimaryColor.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: Text(
                      article.sourceNameOrPlaceholder(),
                      style: const TextStyle(
                        color: AppStyle.originalPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Title ────────────────────────────────────────────
                  TranslatedText(
                    text: article.titleOrFallback(),
                    localeCubit: cubit,
                    style: TextStyle(
                      color: AppStyle.originalPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
                    overflow: TextOverflow.visible,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),

                  const SizedBox(height: 24),

                  // ── Divider ──────────────────────────────────────────
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppStyle.originalPrimaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Body / Description ───────────────────────────────
                  TranslatedText(
                    text: article.descriptionOrFallback(),
                    localeCubit: cubit,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),

                  const SizedBox(height: 40),

                  // ── Read Full Story Button ──────────────────────────
                  _ReadMoreButton(article: article, cubit: cubit),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
class _SliverHeader extends StatelessWidget {
  const _SliverHeader({required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      backgroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.6),
          child: const BackButton(color: Colors.white),
        ),
      ),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            CachedNetworkImage(
              imageUrl: article.imageUrlOrFallback(),
              placeholder: (context, url) => Center(
                child: CircleLoading(color: AppStyle.originalPrimaryColor),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/Event-Image-Not-Found.jpg',
                fit: BoxFit.cover,
              ),
              fit: BoxFit.cover,
            ),
            // Bottom Gradient
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.0, 0.4],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
class _ReadMoreButton extends StatelessWidget {
  const _ReadMoreButton({required this.article, required this.cubit});

  final ArticleModel article;
  final LocaleCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final uri = Uri.parse(article.urlOrFallback());
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyle.originalPrimaryColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          cubit.tn('Read full story on Website', 'اقرأ الخبر كاملاً من المصدر'),
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ),
    );
  }
}
