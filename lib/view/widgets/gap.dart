import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double x;
  final double y;

  const Gap({Key? key, this.x = 0, this.y = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: x,
      height: y,
    );
  }
}
