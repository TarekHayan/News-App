import 'package:flutter/material.dart';

import '../cubit/locale_cubit.dart';

class TranslatedText extends StatelessWidget {
  const TranslatedText({
    super.key,
    required this.text,
    required this.localeCubit,
    required this.style,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  final String text;
  final LocaleCubit localeCubit;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

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
            overflow: overflow ?? TextOverflow.ellipsis,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}
