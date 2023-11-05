import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double size;
  final Widget? child;
  final Color color;

  const Circle({
    Key? key,
    this.size = 32,
    this.child,
    this.color = Colors.purple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(child: child ?? Container()),
    );
  }
}
