import 'dart:async';

import 'package:buble_game/my_ball.dart';
import 'package:buble_game/my_button.dart';
import 'package:buble_game/my_missile.dart';
import 'package:buble_game/player.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

enum Direction { left, right }

class _HomeScreenState extends State<HomeScreen> {
  //player var
  double xPlayer = 0;

  //missile var
  double xMisile = 0;
  double yMissile = 1;

  double missileHeight = 5;

  //shots var
  bool midshot = false;

  //ball var
  double xBall = 0;
  double yBall = 1;
  Direction now = Direction.left;

  //functions method

  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 75;

    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // bounce equation of upside down parabola
      height = -5 * time * time + velocity * time;

      if (height < 0) {
        time = 0;
      }
      setState(() {
        yBall = heightToPosition(height);
      });

      time += 0.1;

      if (xBall < -0.9) {
        now = Direction.left;
      } else if (xBall > 0.9) {
        now = Direction.right;
      }

      if (now == Direction.left) {
        setState(() {
          xBall += 0.005;
        });
      } else if (now == Direction.right) {
        setState(() {
          xBall -= 0.005;
        });
      }

      if (playerDead()) {
        yBall = 0;
        timer.cancel();
        _showDialog();
      }
    });
  }

  void moveRight() {
    setState(() {
      if (xPlayer >= 0.9) {
      } else {
        xPlayer += 0.1;
      }
// only follow the xPlayer coordinate outside the shot

      if (!midshot) {
        xMisile = xPlayer;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (xPlayer <= -0.9) {
      } else {
        xPlayer -= 0.1;
      }
// only follow the xPlayer coordinate outside the shot
      if (!midshot) {
        xMisile = xPlayer;
      }
    });
  }

  void resetMissile() {
    setState(() {
      xMisile = xPlayer;
      missileHeight = 0;
      midshot = false;
    });
  }

  void fireMissile() {
    if (midshot == false) {
      Timer.periodic(const Duration(milliseconds: 20), (timer) {
        // missile shots
        midshot = true;
        // missile grows until hits the top screen
        setState(() {
          missileHeight += 10;
        });

        if (missileHeight > MediaQuery.of(context).size.height * 7 / 8) {
          timer.cancel();
          resetMissile();
          midshot = false;
        }

        if (yBall > heightToPosition(missileHeight) &&
            (xBall - xMisile).abs() < 0.1) {
          xBall = 5;
          timer.cancel();
          resetMissile();
        }
      });
    }
  }

  //when the missile and the ball touches

  // method to change the convert the height to coordinate
  // 1 - (height/total height * 2)

  double heightToPosition(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 7 / 8;
    double missileY = 1 - (2 * height / totalHeight);
    return missileY;
  }

  // player dead when the ball touch the player
  // when the alignment x and y of the ball touch the x and y of the player

  bool playerDead() {
    if ((xPlayer - xBall).abs() < 0.05 && yBall > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  // dialog screen when player dead

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return const AlertDialog(
            title: Text("Yah mati deh..."),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(color: Colors.pink[200]),
              child: Center(
                child: Stack(
                  children: [
                    Player(
                      positions: xPlayer,
                    ),
                    MyMissile(
                      height: missileHeight,
                      x: xMisile,
                      y: yMissile,
                    ),
                    MyBall(
                      x: xBall,
                      y: yBall,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(tap: startGame, myIcon: Icons.start),
                  MyButton(tap: moveLeft, myIcon: Icons.arrow_circle_left),
                  MyButton(tap: fireMissile, myIcon: Icons.arrow_circle_up),
                  MyButton(tap: moveRight, myIcon: Icons.arrow_circle_right)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
