import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/theme/app_styles.dart';
import '../core/widgets/circle_loading.dart';
import '../models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LocaleCubit>();
    final isArabic = cubit.isArabic;

    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: article.imageUrlOrFallback(),
                placeholder: (context, url) => Center(
                  child: CircleLoading(color: AppStyle.originalPrimaryColor),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/Event-Image-Not-Found.jpg',
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
          child: _TranslatedText(
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
        Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: _TranslatedText(
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
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 15, right: 15),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Text(
                cubit.tn('Read more', 'اقرأ المزيد'),
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                ),
              ),
              onTap: () async {
                final url = Uri.parse(article.urlOrFallback());
                await launchUrl(url, mode: LaunchMode.inAppWebView);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TranslatedText extends StatelessWidget {
  const _TranslatedText({
    required this.text,
    required this.localeCubit,
    required this.style,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final LocaleCubit localeCubit;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: localeCubit.translate(text),
      initialData: text,
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            snapshot.data ?? text,
            key: ValueKey(snapshot.data),
            style: style,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}
