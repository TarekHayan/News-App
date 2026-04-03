import 'package:flutter/material.dart';

class ErrorInRequest extends StatelessWidget {
  const ErrorInRequest({super.key, required this.errorMassage});
  final String errorMassage;
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          errorMassage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
