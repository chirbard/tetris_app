import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  int numberOfSquares = 180;
  List<List<int>> pieces = [
    [14, 4, 24, 34],
    [14, 4, 5, 15],
    [14, 13, 15, 5],
    [14, 13, 4, 15],
    [14, 13, 3, 15],
    [14, 4, 3, 15],
    [14, 4, 5, 13]
  ];

  void rotate() {
    setState(() {
      int index = movingPiece[0];
      for (int i = 1; i < 4; i++) {
        int value = index - movingPiece[i];

        switch (value) {
          case 1:
            //left
            movingPiece[i] = index + 10;
            break;
          case -1:
            //right
            movingPiece[i] = index - 10;
            break;
          case 10:
            //up
            movingPiece[i] = index - 1;
            break;
          case -10:
            //down
            movingPiece[i] = index + 1;
            break;
          case 2:
            //left
            movingPiece[i] = index + 20;
            break;
          case -2:
            //right
            movingPiece[i] = index - 20;
            break;
          case 20:
            //up
            movingPiece[i] = index - 2;
            break;
          case -20:
            //down
            movingPiece[i] = index + 2;
            break;
          case 9:
            //topright
            movingPiece[i] = index - 11;
            break;
          case -9:
            //bottomleft
            movingPiece[i] = index + 11;
            break;
          case 11:
            //topleft
            movingPiece[i] = index + 9;
            break;
          case -11:
            //bottomright
            movingPiece[i] = index - 9;
            break;
        }
      }

      // blue
      // if index - blue = 1 left
      // index - blue = -1 right
      // index - blue = 10 top
      // index - blue = -10 bottom

      // red
      // if index - blue = 2 left
      // index - blue = -2 right
      // index - blue = 20 top
      // index - blue = -20 bottom

      // black

      // 9 tr
      // 11 tl
      // -9 bl
      // -11 br
    });
  }

// [i, i-1, i+1, i+2]

// * 0
// *
// *
// * 2

// ** 1
// ** 1

// * 2
// *
// **

// * 3
// **
// * 4

//  * 4
//  *
// ** 4

//  * 5
// **
// *  2

// *  6
// **
//  * 2

  List<int> movingPiece = [];

  List<int> landedPieces = [];

  void startGame() {
    movingPiece = pieces[Random().nextInt(7)];

    const duration = Duration(milliseconds: 400);
    Timer.periodic(duration, (Timer timer) {
      update();
    });
  }

  void update() {
    setState(() {
      if (!movingPiece.every((element) => element < 170) ||
          !movingPiece
              .every((element) => !landedPieces.contains(element + 10))) {
        landedPieces.addAll(movingPiece);
        movingPiece = pieces[Random().nextInt(7)];
      } else {
        movingPiece = movingPiece.map((e) => e + 10).toList();
      }

      for (int i = 0; i < 18; i++) {
        if (landedPieces
                .where((element) => element >= i * 10 && element < (i + 1) * 10)
                .length ==
            10) {
          landedPieces.removeWhere(
              (element) => element >= i * 10 && element < (i + 1) * 10);
          landedPieces =
              landedPieces.map((e) => e < i * 10 ? e + 10 : e).toList();
        }
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!movingPiece.every((element) => element % 10 != 0) ||
          !movingPiece
              .every((element) => !landedPieces.contains(element - 1))) {
        return;
      } else {
        movingPiece = movingPiece.map((e) => e - 1).toList();
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!movingPiece.every((element) => element % 10 != 9) ||
          !movingPiece
              .every((element) => !landedPieces.contains(element + 1))) {
        return;
      } else {
        movingPiece = movingPiece.map((e) => e + 1).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: numberOfSquares,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10),
            itemBuilder: (BuildContext context, int index) {
              if (movingPiece.contains(index)) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                );
              }
              if (landedPieces.contains(index)) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                );
              }
              return Container(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              );
            },
          )),
          Container(
            color: const Color(0xFF1e1e1e),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF010101),
                      minimumSize: const Size.square(60.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: startGame,
                    child: const Text(
                      'PLAY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF010101),
                      minimumSize: const Size.square(60.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: moveLeft,
                    child: const Icon(
                      Icons.arrow_left_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF010101),
                      minimumSize: const Size.square(60.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: moveRight,
                    child: const Icon(
                      Icons.arrow_right_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF010101),
                      minimumSize: const Size.square(60.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: rotate,
                    child: const Icon(
                      Icons.rotate_left_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
