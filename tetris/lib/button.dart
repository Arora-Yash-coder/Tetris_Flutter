import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // Content shown in the button
  final Widget child;

  const MyButton({Key? key, required this.child}) : super(key: key);

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
