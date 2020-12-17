import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pong/game.dart';

class PongPainter extends CustomPainter {
  final Pong pong;
  final Orientation orientation;

  PongPainter(this.pong, this.orientation) : super(repaint: pong);
  @override
  void paint(Canvas canvas, Size size) {
    initCanvas(canvas, size);
    drawCenterLine(canvas);

    final playerPaint = Paint()..color = Colors.white;
    drawPlayer(pong.player, canvas, playerPaint);
    drawPlayer(pong.enemy, canvas, playerPaint);
    drawBall(canvas);
  }

  void initCanvas(Canvas canvas, Size size) {
    if (orientation == Orientation.portrait) {
      canvas.rotate(-pi / 2);
      canvas.scale(size.height / table.width, size.width / table.height);
      canvas.translate(-table.width, 0);
    } else {
      canvas.scale(size.width / table.width, size.height / table.height);
    }
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

  void drawPlayer(Player player, Canvas canvas, Paint paint) {
    canvas.drawRect(
        Rect.fromCenter(
            center: player.position,
            width: playerSize.width,
            height: playerSize.height),
        paint);
  }

  void drawBall(Canvas canvas) {
    canvas.drawRect(
        Rect.fromCircle(center: pong.ballPosition, radius: ballRadius),
        Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
