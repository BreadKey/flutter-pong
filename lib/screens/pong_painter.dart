import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pong/game.dart';

class PongPainter extends CustomPainter {
  final Pong pong;
  final Orientation orientation;

  PongPainter(this.pong, this.orientation);
  @override
  void paint(Canvas canvas, Size size) {
    if (orientation == Orientation.portrait) {
      canvas.rotate(-pi / 2);
      canvas.scale(size.height / table.width, size.width / table.height);
      canvas.translate(-table.width, 0);
    } else {
      canvas.scale(size.width / table.width, size.height / table.height);
    }

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = playerSize.width;

    canvas.drawLine(table.topCenter, table.bottomCenter, paint);
    canvas.drawRect(
        Rect.fromCenter(
            center: pong.player.position,
            width: playerSize.width,
            height: playerSize.height),
        paint);

    canvas.drawRect(
        Rect.fromCenter(
            center: pong.enemy.position,
            width: playerSize.width,
            height: playerSize.height),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
