import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalDividerWithDots extends StatelessWidget {
  const VerticalDividerWithDots({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(2, double.infinity), // Adjust the width of the divider as needed
      painter: DottedVerticalLinePainter(),
    );
  }
}
class DottedVerticalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent // Change the color of the dots as needed
      ..strokeWidth = 2; // Adjust the dot size as needed

    final double dashWidth = 5; // Adjust the width of the dashes
    final double dashSpace = 3; // Adjust the space between dashes

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}