import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  MyButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        color: Colors.black,
        child: Center(child: child),
      ),
    );
  }
}
