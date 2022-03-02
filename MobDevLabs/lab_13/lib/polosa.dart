
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Polosa extends StatefulWidget {
  Polosa({Key? key, this.rows = 20, this.columns = 20, this.cellSize = 10.0})
      : super(key: key) {
    assert(10 <= rows);
    assert(10 <= columns);
    assert(5.0 <= cellSize);
  }

  final int rows;
  final int columns;
  final double cellSize;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => PolosaState(rows, columns, cellSize);
}

class PolosaPainter extends CustomPainter {
  PolosaPainter(this.state, this.cellSize);

  GameState? state;
  double cellSize;

  @override
  void paint(Canvas canvas, Size size) {
    final blackLine = Paint()..color = Colors.black;
    final blackFilled = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromPoints(Offset.zero, size.bottomLeft(Offset.zero)),
      blackLine,
    );
    for (final p in state!.body) {
      final a = Offset(cellSize * p.x, cellSize * p.y);
      final b = Offset(cellSize * (p.x + 1), cellSize * (p.y + 1));

      canvas.drawRect(Rect.fromPoints(a, b), blackFilled);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PolosaState extends State<Polosa> {
  PolosaState(int rows, int columns, this.cellSize) {
    state = GameState(rows, columns);
  }

  double cellSize;
  GameState? state;
  AccelerometerEvent? acceleration;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  //таймер опроса
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: PolosaPainter(state, cellSize));
  }
int a=1;
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      setState(() {
        state!.step(math.Point<int>(0,1));
      });
    });
  }
  
}

class GameState {
  GameState(this.rows, this.columns) {
    polosaLenght = 6;
  }

  int rows;
  int columns;
  late int polosaLenght;

  List<math.Point<int>> body = <math.Point<int>>[const math.Point<int>(10, 0)];
  math.Point<int> direction = const math.Point<int>(0, 0);

  void step(math.Point<int>? newDirection) {
    var next = body.last + direction;
    next = math.Point<int>(next.x % columns, next.y % rows);

    body.add(next);
    if (body.length > polosaLenght) body.removeAt(0);
    direction = newDirection ?? direction;
  }

}