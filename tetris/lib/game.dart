import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/button.dart';
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

  int number = 0;
  double count = 0;

  //Starts the game
  void startGame() {
    resetPieces();
    choosePiece();
    //Speed of the game
    const duration = Duration(milliseconds: 300);
    Timer.periodic(
      duration,
      (Timer timer) {
        if (hitFloor()) {
          timer.cancel();
          // startGame();
        } else {
          moveDown();
        }
      },
    );
  }

  //Resets the game
  void resetPieces() {}
  //Clears the rows filled
  void clearRow() {}
  //Choses a randonm piece
  void choosePiece() {
    setState(() {
      Random random = Random();
      chosenPiece = pieces[random.nextInt(pieces.length)];
      print(chosenPiece);
    });
  }

  //Moves the chosen piece down
  void moveDown() {
    setState(() {
      for (var i = 0; i < chosenPiece.length; i++) {
        chosenPiece[i] += 10;
      }
    });
  }

  //Moves the chosen piece Left
  void moveLeft() {
    setState(() {
      for (var i = 0; i < chosenPiece.length; i++) {
        chosenPiece[i] -= 1;
      }
    });
  }

  //Moves the chosen piece Right
  void moveRight() {
    setState(() {
      for (var i = 0; i < chosenPiece.length; i++) {
        chosenPiece[i] += 1;
      }
    });
  }

  //Rotates the chosen piece
  void rotatePiece() {}
  //Checks if chosen piece stoped
  bool hitFloor() {
    bool hitFloor = false;
    chosenPiece.sort();
    if (chosenPiece.last + 10 >= 180) {
      hitFloor = true;
    }

    // for (var i = 0; i < chosenPiece.length; i++) {
    //   if (landed.contains(chosenPiece[i] + 10)) {
    //     hitFloor = true;
    //   }
    // }
    return hitFloor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: MyGrid(
            newPiece: chosenPiece,
            newColor: pieceColor[0],
          ),
        ),
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: startGame,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: MyButton(
                          child: const Text(
                            "PLAY",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: moveLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: MyButton(
                          child: const Icon(
                            Icons.arrow_left_rounded,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: moveRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: MyButton(
                          child: const Icon(
                            Icons.arrow_right_rounded,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: rotatePiece,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: MyButton(
                          child: const Icon(Icons.rotate_right_rounded),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
