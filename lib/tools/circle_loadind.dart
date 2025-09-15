import 'package:flutter/material.dart';

class CircleLoadind extends StatelessWidget {
  const CircleLoadind({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color);
  }
}
