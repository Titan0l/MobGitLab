
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Draws a circular animated progress bar.
class CircleProgressBar extends StatefulWidget {
  final Duration? animationDuration;
 
  final Color foregroundColor;
  final double value;

  const CircleProgressBar({
    Key? key,
     this.animationDuration,
    
    required this.foregroundColor,
    required this.value,
  }) : super(key: key);

  @override
  CircleProgressBarState createState() {
    return CircleProgressBarState();
  }
}

class CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  // Used in tweens where a backgroundColor isn't given.
  static const TRANSPARENT = Color(0x00000000);
  late AnimationController _controller;

  late Animation<double> curve;
  late Tween<double> valueTween;

  late ColorTween foregroundColorTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(seconds: 1),
      vsync: this,
    );

    curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Build the initial required tweens.
    valueTween = Tween<double>(
      begin: 0,
      end: widget.value,
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(CircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      // Try to start with the previous tween's end value. This ensures that we
      // have a smooth transition from where the previous animation reached.
      double beginValue =
          valueTween?.evaluate(curve) ?? oldWidget?.value ?? 0;

      // Update the value tween.
      valueTween = Tween<double>(
        begin: beginValue,
        end: widget.value ?? 1,
      );

      _controller
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: curve,
        child: Container(),
        builder: (context, child) {

          final foregroundColor =Colors.red;

          return CustomPaint(
            child: child,
            foregroundPainter: CircleProgressBarPainter(

              foregroundColor: foregroundColor,
              percentage: valueTween.evaluate(curve),
            ),
          );
        },
      ),
    );
  }
}

// Draws the progress bar.
class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;

  final Color foregroundColor;

  CircleProgressBarPainter({

    required this.foregroundColor,
    required this.percentage,
    double? strokeWidth,
  }) : strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final shortestSide = Math.min(size.width-strokeWidth, size.height-strokeWidth);
    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * (percentage ?? 0));

    // Don't draw the background if we don't have a background color


    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      true,
      foregroundPaint,
    );
   
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != percentage ||
        oldPainter.foregroundColor != foregroundColor ||
        oldPainter.strokeWidth != strokeWidth;
  }
}