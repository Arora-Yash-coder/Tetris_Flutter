import 'package:flutter/material.dart';
import 'package:tetris/pixel.dart';

class MyGrid extends StatelessWidget {
  // List of all the peices landed
  final landedPieces;
  // The new piece which spawned;
  final newPiece;
  // The color of new piece
  final newColor;

  final pieceColor;

  MyGrid({this.landedPieces, this.newColor, this.newPiece, this.pieceColor});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 180,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemBuilder: (BuildContext context, int index) {
          // for (var i = 0; i < pieceColor.length; i++) {
          //   if (landedPieces[i].contains(index)) {
          //     return MyPixel(
          //       color: pieceColor[i],
          //     );
          //   }
          // }
          // if (newPiece.contains(index)) {
          //   return MyPixel(
          //     color: newColor,
          //   );
          // } else {
          //   return MyPixel(
          //     color: Colors.black,
          //   );
          // }

          return MyPixel(color: Colors.black);
        });
  }
}
