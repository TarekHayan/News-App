import '../cubit/locale_cubit.dart';

/// عناوين فئات الأخبار (مفاتيح الـ API → عرض حسب اللغة).
String localizedCategoryLabel(LocaleCubit l, String apiKey) {
  switch (apiKey.toLowerCase()) {
    case 'business':
      return l.tn('Business', 'أعمال');
    case 'entertainment':
      return l.tn('Entertainment', 'ترفيه');
    case 'health':
      return l.tn('Health', 'صحة');
    case 'science':
      return l.tn('Science', 'علوم');
    case 'sports':
      return l.tn('Sports', 'رياضة');
    case 'technology':
      return l.tn('Technology', 'تقنية');
    case 'general':
      return l.tn('General', 'عام');
    default:
      return apiKey;
  }
}
