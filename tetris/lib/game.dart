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
  List<List<int>> pieces = [
    [4, 5, 14, 15],
    [4, 14, 24, 25],
    [5, 15, 24, 25],
    [4, 14, 24, 34],
    [4, 14, 15, 25],
    [5, 15, 14, 24],
    [4, 5, 6, 15],
  ];
  //All types of Colors
  List<Color> pieceColor = [
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.brown,
    Colors.pink,
  ];
  // The new piece spawned
  List<int> chosenPiece = [];
  // The pieces which landed
  List<int> landed = [];
  // All the positions needed to be filled
  List<List<int>> landedPosColor = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  // Variable representing number of blocks landed
  int number = 0;
  // Variable representing score
  int score = 0;
  // Checks if the game ended
  bool check = false;

  //Starts the game
  void startGame() {
    if (check) {
      _showDialog();
    } else {
      choosePiece();
      //Speed of the game
      const duration = Duration(milliseconds: 200);
      Timer.periodic(
        duration,
        (Timer timer) {
          check = gameEnded();
          clearRow();
          if (hitFloor()) {
            for (var i = 0; i < chosenPiece.length; i++) {
              landed.add(chosenPiece[i]);
              landedPosColor[number % pieces.length].add(chosenPiece[i]);
            }
            number++;
            startGame();
            timer.cancel();
          } else {
            moveDown();
          }
        },
      );
    }
  }

  //Clears the rows filled
  void clearRow() {
    int count;
    List<int> removeRow = [];

    for (var i = 0; i < 18; i++) {
      removeRow.clear();
      count = 0;
      for (var j = 0; j < 10; j++) {
        if (landed.contains(179 - i * 10 - j)) {
          removeRow.add(179 - i * 10 - j);
          count++;
        }
        if (count == 10) {
          setState(() {
            for (var element in removeRow) {
              landed.remove(element);
            }
            for (var q = 0; q < pieces.length; q++) {
              for (var element in removeRow) {
                landedPosColor[q].remove(element);
              }
            }

            for (var i = 0; i < landed.length; i++) {
              if (landed[i] < removeRow.first) {
                landed[i] += 10;
              }
            }

            for (var q = 0; q < landedPosColor.length; q++) {
              for (var r = 0; r < landedPosColor[q].length; r++) {
                if (landedPosColor[q][r] < removeRow.first) {
                  landedPosColor[q][r] += 10;
                }
              }
            }
            score++;
          });
        }
      }
    }
  }

  //Choses a randonm piece
  void choosePiece() {
    setState(() {
      Random random = Random();
      int temp = random.nextInt(6);
      chosenPiece = List<int>.of(pieces[temp]);
      // print('chosen Peice:${chosenPiece}');
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
    if (chosenPiece.any(
        (element) => (element) % 10 == 0 || landed.contains(element - 1))) {
    } else {
      setState(() {
        for (var i = 0; i < chosenPiece.length; i++) {
          chosenPiece[i] -= 1;
        }
      });
    }
    for (var i = 0; i < chosenPiece.length; i++) {
      if (landed.contains(chosenPiece[i] - 1) ||
          (chosenPiece[i] - 1) % 10 == 0) {}
    }
  }

  //Moves the chosen piece Right
  void moveRight() {
    if (chosenPiece.any(
        (element) => (element + 1) % 10 == 0 || landed.contains(element + 1))) {
    } else {
      setState(() {
        for (var i = 0; i < chosenPiece.length; i++) {
          chosenPiece[i] += 1;
        }
      });
    }
    for (var i = 0; i < chosenPiece.length; i++) {
      if (landed.contains(chosenPiece[i] + 1) ||
          (chosenPiece[i] - 1) % 10 == 0) {}
    }
  }

  //Rotates the chosen piece
  void rotatePiece() {
    final snackBar = SnackBar(
      backgroundColor: Colors.grey.shade800,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: const [
            Text(
              'This aint no easy Game',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'NOOB',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //Checks if chosen piece stoped
  bool hitFloor() {
    bool hitFloor = false;
    chosenPiece.sort();
    if (chosenPiece.last + 10 >= 180) {
      hitFloor = true;
    }

    for (var i = 0; i < chosenPiece.length; i++) {
      if (landed.contains(chosenPiece[i] + 10)) {
        hitFloor = true;
      }
    }
    return hitFloor;
  }

  // Resets the game
  void resetGame() {
    Navigator.pop(context);
    setState(() {
      check = false;
      landedPosColor = [
        [],
        [],
        [],
        [],
        [],
        [],
        [],
      ];
      chosenPiece = [];
      landed = [];
      number = 0;
      score = 0;
      startGame();
    });
  }

  //Shows the score
  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 10),
            actionsPadding: const EdgeInsets.only(bottom: 10),
            backgroundColor: Colors.grey.shade800,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "GAME OVER",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Tetris',
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "SCORE : $score",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Tetris',
                      fontSize: 25,
                    ),
                  ),
                ],
              ), // Text
            ), // Center
            actions: [
              Center(
                child: GestureDetector(
                  onTap: resetGame,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      color: Colors.white,
                      child: Text(
                        "PLAY AGAIN",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontFamily: 'Tetris',
                          fontSize: 20,
                        ),
                      ), // Text
                    ), // Container
                  ), // ClipRRect
                ),
              ) // GestureDetector
            ],
          ); // AlertDialog
        });
  }

  //Checks if the game ended
  bool gameEnded() {
    for (int i = 0; i < landedPosColor.length - 1; i++) {
      for (int j = i + 1; j < landedPosColor.length; j++) {
        if (landedPosColor[i].any((item) => landedPosColor[j].contains(item))) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: MyGrid(
            landedPieces: landedPosColor,
            newPiece: chosenPiece,
            newColor: pieceColor[number % pieces.length],
          ),
        ),
        Expanded(
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
                            fontSize: 30,
                            fontFamily: 'Tetris',
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
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
