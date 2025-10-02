class Articalmodel {
  final String? image;
  final String? title;
  final String? des;
  final String? url;
  Articalmodel({
    required this.image,
    required this.title,
    required this.des,
    required this.url,
  });

  factory Articalmodel.fromJason(jason) {
    return Articalmodel(
      image: jason["urlToImage"],
      title: jason["title"],
      des: jason["description"],
      url: jason["url"],
    );
  }

  String checkImage() {
    if (image == null || image!.isEmpty) {
      return 'assets/Event-Image-Not-Found.jpg';
    }
    return image!;
  }

  String checkTitle() {
    if (title == null || title!.isEmpty) {
      return 'not title in this news';
    }
    return title!;
  }

  String checkdes() {
    if (des == null || des!.isEmpty) {
      return 'not describtion in this news';
    }
    return des!;
  }

  String checkurl() {
    if (url == null || url!.isEmpty) {
      return "https://www.webpagetest.org/blank.html";
    }
    return url!;
  }
}
