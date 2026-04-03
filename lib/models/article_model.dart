class ArticleModel {
  const ArticleModel({
    required this.image,
    required this.title,
    required this.description,
    required this.url,
    this.sourceName,
  });

  final String? image;
  final String? title;
  final String? description;
  final String? url;

  /// اسم المصدر من حقل `source.name` في News API.
  final String? sourceName;

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    String? source;
    final src = json['source'];
    if (src is Map) {
      final n = src['name'];
      if (n is String) source = n;
    }

    return ArticleModel(
      image: json['urlToImage'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      sourceName: source,
    );
  }

  String imageUrlOrFallback() {
    if (image == null || image!.isEmpty) {
      return 'assets/Event-Image-Not-Found.jpg';
    }
    return image!;
  }

  String titleOrFallback() {
    if (title == null || title!.isEmpty) {
      return 'not title in this news';
    }
    return title!;
  }

  String descriptionOrFallback() {
    if (description == null || description!.isEmpty) {
      return 'not describtion in this news';
    }
    return description!;
  }

  String urlOrFallback() {
    if (url == null || url!.isEmpty) {
      return 'https://www.webpagetest.org/blank.html';
    }
    return url!;
  }

  String sourceNameOrPlaceholder() {
    if (sourceName != null && sourceName!.trim().isNotEmpty) {
      return sourceName!.trim();
    }
    return '';
  }
}
