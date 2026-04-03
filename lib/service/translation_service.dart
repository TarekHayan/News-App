import 'package:dio/dio.dart';

class TranslationService {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  /// Translates [text] from English to [targetLang] using the free MyMemory API.
  /// Returns the original [text] unchanged if translation fails.
  static Future<String> translate(String text, String targetLang) async {
    if (text.isEmpty) return text;
    try {
      final response = await _dio.get(
        'https://api.mymemory.translated.net/get',
        queryParameters: {
          'q': text,
          'langpair': 'en|$targetLang',
        },
      );
      final data = response.data;
      if (data is Map && data['responseStatus'] == 200) {
        final translated =
            data['responseData']?['translatedText'] as String?;
        if (translated != null && translated.isNotEmpty) {
          return translated;
        }
      }
      return text;
    } catch (_) {
      // Network error or API limit reached — fall back to original text
      return text;
    }
  }
}
