import 'package:flutter/material.dart';
import '../models/card_data.dart';
import '../views/categry_news.dart';

class Categerycards extends StatelessWidget {
  const Categerycards({super.key, required this.card});
  final CardData card;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return CategryNews(categry: card.text);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(card.image),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              card.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
