//circle_painter.dart
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final Offset center;
  final double radius;
  final Color color;
  final double strokeWidth;
  Circle(
      {this.center,
      this.radius,
      this.color = Colors.black,
      this.strokeWidth = 1});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // size: Size(MediaQuery.of(context).size.width,
      //     MediaQuery.of(context).size.height),
      painter: DrawCircle(
        center: center,
        radius: radius,
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class DrawCircle extends CustomPainter {
  final Offset center;
  final double radius;
  final Color color;
  final double strokeWidth;
  DrawCircle({this.center, this.radius, this.color, this.strokeWidth});
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(Offset(center.dx, center.dy), radius, brush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
