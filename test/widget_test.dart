import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news_app/core/cubit/locale_cubit.dart';

void main() {
  testWidgets('LocaleCubit exposes language in UI', (WidgetTester tester) async {
    final cubit = LocaleCubit('ar');

    await tester.pumpWidget(
      BlocProvider<LocaleCubit>.value(
        value: cubit,
        child: MaterialApp(
          home: Scaffold(
            body: BlocBuilder<LocaleCubit, String>(
              builder: (context, lang) {
                return Text(lang);
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('ar'), findsOneWidget);
  });
}
