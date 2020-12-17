import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pong/game.dart';
import 'package:pong/screens/pong_painter.dart';

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Pong pong;

  @override
  void initState() {
    super.initState();
    pong = Pong();
    pong.init();
    pong.start();
  }

  @override
  void dispose() {
    pong.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
      child: OrientationBuilder(
          builder: (context, orientation) => RepaintBoundary(
                child: CustomPaint(
                  key: ValueKey(pong),
                  painter: PongPainter(pong, orientation),
                ),
              )));
}