import 'package:flutter/material.dart';
import 'package:tetris/button.dart';

class MyPixel extends StatelessWidget {
  late final color;

  MyPixel({this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: MyButton(),
      ),
    );
  }
}
