import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris/grid.dart';

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  // All types of pieces
  static List<List<int>> pieces = [
    [4, 5, 14, 15],
    [4, 14, 24, 25],
    [5, 15, 24, 25],
    [4, 14, 24, 34],
    [4, 14, 15, 25],
    [5, 15, 14, 24],
    [4, 5, 6, 15]
  ];
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

  List<int> chosenPiece = [];
  List<int> landed = [];
  List<List<int>> landedPosColor = [];

  static int number = 0;
  double count = 0;

  //Starts the game
  void startGame() {
    resetPieces();
    choosePiece();
    //Speed of the game
    const duration = Duration(milliseconds: 300);
    Timer.periodic(
      duration,
      (Timer timer) {},
      //
    );
  }

  //Resets the game
  void resetPieces() {}
  //Clears the rows filled
  void clearRow() {}
  //Choses a randonm piece
  void choosePiece() {}
  //Moves the chosen piece down
  void moveDown() {}
  //Moves the chosen piece Left
  void moveLeft() {}
  //Moves the chosen piece Right
  void moveRight() {}
  //Rotates the chosen piece
  void rotatePiece() {}
  //Checks if chosen piece stoped
  bool hitFloor() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MyGrid(),
        ),
        Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(
                child: Text("1"),
              ),
              Expanded(
                child: Text("2"),
              ),
              Expanded(
                child: Text("3"),
              ),
              Expanded(
                child: Text("4"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
