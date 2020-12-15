import 'package:flutter/material.dart';
import 'package:pong/game.dart';
import 'package:pong/screens/pong_painter.dart';

class GameScreen extends StatelessWidget {
  final pong = Pong()..init();
  @override
  Widget build(BuildContext context) => SizedBox.expand(
          child: OrientationBuilder(
        builder: (context, orientation) => CustomPaint(
          painter: PongPainter(pong, orientation),
        ),
      ));
}
