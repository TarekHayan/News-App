import 'package:flutter/material.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color);
  }
}
