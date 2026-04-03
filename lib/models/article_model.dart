class ArticleModel {
  const ArticleModel({
    required this.image,
    required this.title,
    required this.description,
    required this.url,
  });

  final String? image;
  final String? title;
  final String? description;
  final String? url;

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      image: json['urlToImage'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
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
}
