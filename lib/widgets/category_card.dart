import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/cubit/locale_cubit.dart';
import '../core/localization/localized_strings.dart';
import '../models/card_data.dart';
import '../views/category_news_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.card});

  final CardData card;

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>();
    final title = localizedCategoryLabel(locale, card.text);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => CategoryNewsScreen(category: card.text),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 10),
        child: Container(
          height: 110,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(card.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
              ),
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
