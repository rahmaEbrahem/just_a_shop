import 'package:flutter/material.dart';

class Subtitles extends StatelessWidget {
  final String subtitle;
  const Subtitles({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Text(subtitle, style: Theme.of(context).textTheme.titleLarge);
  }
}
