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

    final paint = Paint()..color = Colors.white;

    drawCenterLine(canvas);

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

  void drawCenterLine(Canvas canvas) {
    const centerLineWidth = 5.0;
    const dotCount = 25;

    final centerLinePath = Path();
    final centerLinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = centerLineWidth
      ..style = PaintingStyle.stroke;

    final topCenter = table.topCenter;
    final bottomCenter = table.bottomCenter;

    double currentY = topCenter.dy;

    centerLinePath.moveTo(topCenter.dx, topCenter.dy);
    bool isLine = true;
    final space = table.height / (dotCount * 2 - 1);

    while (currentY < bottomCenter.dy) {
      final nextY = currentY + space;
      isLine
          ? centerLinePath.lineTo(bottomCenter.dx, nextY)
          : centerLinePath.moveTo(bottomCenter.dx, nextY);

      currentY = nextY;
      isLine = !isLine;
    }

    canvas.drawPath(centerLinePath, centerLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
