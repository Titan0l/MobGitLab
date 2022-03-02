import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Класс рисования анимированный путь самолета
class CircleTrack extends StatefulWidget {
  //Продолжительность анимации
  final Duration? animationDuration;
  //Цвет пути
  final Color foregroundColor;
  //Значение пройденного пути
  final double value;
  //Конструктор по умолчанию
  const CircleTrack({
    Key? key,
    this.animationDuration,
    required this.foregroundColor,
    required this.value,
  }) : super(key: key);
  //Создание состояния класса с возвратом экземпляра класса
  @override
  CircleTrackState createState() {
    return CircleTrackState();
  }
}
//Создание состояния с использованием тикера для обработки кадров AnimationController
class CircleTrackState extends State<CircleTrack>
    with SingleTickerProviderStateMixin {
//Создание контроллера анимации
  late AnimationController _controller;
  //Значение кривизны
  late Animation<double> curve;
  //Значение анимации
  late Tween<double> valueTween;
// Цвет дуги
  late ColorTween foregroundColorTween;
//Действия при инициализации
  @override
  void initState() {
    super.initState();
//инициализация контроллера с временем рисования отрезка в 200 миллисекунд
    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
      vsync: this,
    );
//инициализация  анимации  "кривой" с выбором нарастающей анимации "easeInOut"
    curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Создаем начальную требуемую анимацию движения
    valueTween = Tween<double>(
      begin: 0,
      end: widget.value,
    );
//Запускаем анимацию
    _controller.forward();
  }
//Переопределяем функцию обновления старого виджета на новый
  @override
  void didUpdateWidget(CircleTrack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
// Начинаем с конечного значения предыдущей анимации движения. 
//Это гарантирует, что плавный переход от того места, где была предыдущая анимация.
      double beginValue = valueTween.evaluate(curve);

      // Обновляем значение анимации
      valueTween = Tween<double>(
        begin: beginValue,
        end: widget.value,
      );
      // Обнуляем значение контроллера и запускаем анимацию
      _controller
        ..value = 0
        ..forward();
    }
  }
// Действия при завершении работы класса
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
//Описывает часть пользовательского интерфейса, представленную этим виджетом
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedBuilder(
        animation: curve,
        child: Container(),
        builder: (context, child) {
          final foregroundColor = Colors.red;
//Возвращаем виджет ручного рисования
          return CustomPaint(
            child: child,
            foregroundPainter: CirclePainter(
              foregroundColor: foregroundColor,
              percentage: valueTween.evaluate(curve),
            ),
          );
        },
      ),
    );
  }
}

// Виджет рисования
class CirclePainter extends CustomPainter {
  //Процент завершения пути
  final double percentage;
    //ширина виджета
  final double strokeWidth;
  //Цвет пути
  final Color foregroundColor;
  //Конструктор класса
  CirclePainter({
    required this.foregroundColor,
    required this.percentage,
    double? strokeWidth,
  }) : strokeWidth = strokeWidth ?? 6;
//Canvas используют объект Paint для описания стиля, используемого для рисования. ( Цвет линии, ее закругление на конце, стиль, ширина краев)
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    const radius = 77.0;

    // Расчет угла
    final double startAngle = -(2 * Math.pi * 0.25);
    final double sweepAngle = (2 * Math.pi * (percentage));
    //Рисование на холсте
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }
// Перерисовка холста
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CirclePainter);
    //Возвращает перерисованный объект при изменении его свойств
    return oldPainter.percentage != percentage ||
        oldPainter.foregroundColor != foregroundColor ||
        oldPainter.strokeWidth != strokeWidth;
  }
}
