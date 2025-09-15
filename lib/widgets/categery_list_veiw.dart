import 'package:flutter/material.dart';
import 'package:news_app/models/card_data.dart';
import 'package:news_app/widgets/categeryCards.dart';

class CategeryListVeiw extends StatelessWidget {
  const CategeryListVeiw({super.key});
  final List<CardData> cards = const [
    CardData(
      image: "assets/mike-kononov-lFv0V3_2H6s-unsplash.jpg",
      text: "business",
    ),
    CardData(
      image: "assets/jonas-von-werne-8VcWVVsrPBk-unsplash.jpg",
      text: "entertainment",
    ),
    CardData(image: "assets/health.avif", text: "health"),
    CardData(
      image: "assets/national-cancer-institute-L7en7Lb-Ovc-unsplash.jpg",
      text: "science",
    ),
    CardData(
      image: "assets/timothy-tan-PAe2UhGo-S4-unsplash.jpg",
      text: "sports",
    ),
    CardData(
      image: "assets/ales-nesetril-Im7lZjxeLhg-unsplash.jpg",
      text: "technology",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Categerycards(card: cards[index]);
        },
      ),
    );
  }
}
