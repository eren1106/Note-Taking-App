import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final double py;
  const TextDivider({
    Key? key,
    required this.text,
    this.py = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: py),
      child: Row(children: <Widget>[
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Text(text),
        ),
        const Expanded(child: Divider()),
      ]),
    );
  }
}
