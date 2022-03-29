import 'package:flutter/material.dart';
import 'package:tetris/pixel.dart';

class MyGrid extends StatefulWidget {
  // List of all the peices landed
  final List<List<int>> landedPieces;
  // The new piece which spawned;
  final List<int> newPiece;
  // The color of new piece
  final Color newColor;

  const MyGrid({
    Key? key,
    required this.landedPieces,
    required this.newColor,
    required this.newPiece,
  }) : super(key: key);

  @override
  State<MyGrid> createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  //All types of Colors
  List<Color> pieceColor = [
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 180,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemBuilder: (BuildContext context, int index) {
          for (var i = 0; i < pieceColor.length; i++) {
            if (widget.landedPieces[i].contains(index)) {
              return MyPixel(
                color: pieceColor[i],
              );
            }
          }
          if (widget.newPiece.contains(index)) {
            return MyPixel(
              color: widget.newColor,
            );
          } else {
            return const MyPixel(
              color: Colors.black,
            );
          }
        });
  }
}
