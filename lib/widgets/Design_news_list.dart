import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/articalModel.dart';
import '../core/tools/circle_loadind.dart';
import '../core/utils/app_styles.dart';
import '../core/providers/locale_provider.dart';

class DesignNewsList extends StatelessWidget {
  const DesignNewsList({super.key, required this.articalmodel});
  final Articalmodel articalmodel;

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final isArabic = locale.isArabic;

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // ── Image ──────────────────────────────────────────────────
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

        // ── Title (translated) ─────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: _TranslatedText(
            text: articalmodel.checkTitle(),
            locale: locale,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppStyle.originalPrimaryColor,
            ),
            maxLines: 2,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
        ),

        // ── Description (translated) ───────────────────────────────
        Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: _TranslatedText(
            text: articalmodel.checkdes(),
            locale: locale,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 3,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
        ),

        // ── Read More ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 15, right: 15),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Text(
                isArabic ? 'اقرأ المزيد' : 'Read More',
                style: const TextStyle(
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
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
/// A widget that shows the original [text] immediately, then replaces it with
/// the translated version once the Future resolves. Uses the provider's cache
/// so repeated builds are instant after the first translation.
class _TranslatedText extends StatelessWidget {
  const _TranslatedText({
    required this.text,
    required this.locale,
    required this.style,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final LocaleProvider locale;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      // If language is English, translate() returns immediately
      future: locale.translate(text),
      initialData: text, // show original while loading
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
