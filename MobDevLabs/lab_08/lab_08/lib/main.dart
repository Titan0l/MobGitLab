import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'track.dart';

void main() => runApp(MyApp());

  //Класс глобальных переменных
class Globals {
  //Перменная процента пройденного пути самолета
  static double progressPercent = 0;
}

class MyApp extends StatelessWidget {
  //Построение приложения с использованием дизайна виджетов MaterialApp,  и домашним экраном MyHomePage
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab08',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //виджет по умолчанию
      home: MyHomePage(title: 'Лабораторная работа №8'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  //Key - ключ вызваемого виджета.
  // Новый виджет будет использоваться для обновления существующего элемента,
  // только если его ключ совпадает с ключом текущего виджета, связанного с элементом.

  //super используется для вызова конструктора базового класса

  final String title;
  @override
  //Создает изменяемое состояние для виджета страницы
  _MyHomePageState createState() => _MyHomePageState();
}

/////////////////////Класс виджета отображения пути самолета/////////////////////////////
class TrackAirplane extends StatefulWidget {
  //Определение состояния класса
  @override
  _TrackAirplaneState createState() => _TrackAirplaneState();
}

class _TrackAirplaneState extends State<TrackAirplane> {
  @override
  Widget build(BuildContext context) {
  // Цвет пути самолета
    Color foreground = Colors.red;
  //Возвращает центрированный виджет пути самолета 
    return Center(
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          //Дочерний виджет пути самолета
          child: CircleTrack(
                    foregroundColor: foreground,
                    value: Globals.progressPercent,
                  ),
        ),
      ),
    );
  }
}
/////////////////////Класс виджета основного экрана/////////////////////////////
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // Создание контроллера для анимации вращения
  late AnimationController _controllerSpin;
  // Создание флага анимации
  bool isAnimating = false;
  // Создание таймера
  late Timer timer;
  // Начальный угол самолета
  double startAngle = -(2 * Math.pi * 0.25);
// Координаты положения самолета
   double x = 77 * Math.cos(-(2 * Math.pi * 0.25));
   double y = 77 * Math.sin(-(2 * Math.pi * 0.25));
// Действия при инициализации приложения
  @override
  void initState() {
    super.initState();
    _controllerSpin =
        AnimationController(vsync: this, duration: Duration(seconds: 51));
  }
//Функция запуска анимации движения самолета
  void starAnimation() {
    // Таймер повторения действий
    timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      // Расчет угла
      double sweepAngle = (2 * Math.pi * (Globals.progressPercent));
      //Расчет новых координат
      x = 77 * Math.cos(startAngle + sweepAngle);
      y = 77 * Math.sin(startAngle + sweepAngle);
      //Обновление экрана
      setState(() {});
      //Прогресс прохождения самолетом пути
      Globals.progressPercent += 0.001;
    });
  }
// Действия при закрытии приложения
  void dispose() {
    _controllerSpin.dispose();
    super.dispose();
  }
// виджет создания контекста
//Описывает часть пользовательского интерфейса, представленную этим виджетом
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
//Строитель возвращает виджет Scaffold, который реализует базовую структуру визуального макета материального дизайна.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Text(widget.title),
        ),
      ),
//Виджет центрирования дочерних виджетов относительно экрана      
      body: Center(
          heightFactor: heightScreen,
          widthFactor: widthScreen,
          child: LayoutBuilder(builder: (context, constraints) {
//Создание переменной размера контейнера рабочей области экрана
            final Size biggest = constraints.biggest;
//Параметры для расчета положения самолета относительно размеров экрана (высоты и ширины)
            double topDist = (biggest.height / 2 - 10);
            double leftDist = (biggest.width / 2 - 10);
//Использование виджета Stack для наслаивания виджетов траектории самолета и самого самолета.
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
//Вывод расчета координат х, у         
                Text('x-$x ,y-$y'),
//Виджет перемещения для самолета по траектории окружности. Позиция расчитывается относительно левой и правой стороны экрана минус половина размера самолета. 
                Positioned(
                  top: topDist + y,
                  left: leftDist + x,
//Виджет создания анимации, у которого дочерний элемент - виджет трансформации вращения.      
                  child: AnimatedBuilder(
                    animation: _controllerSpin,
                    builder: (_, child) {
//Возвращаем развернутый самолет на n-ое количество градусов. Градус расчитывается в зависимости от времени проигрывания виджета. 
                      return Transform.rotate(
                        angle: _controllerSpin.value * 2 * Math.pi,
                        child: child,
                      );
                    },
//Виджет коробки для изначального разворота самолета на 90 градусов 
                    child: RotatedBox(
                        quarterTurns: 1, child: Icon(Icons.airplanemode_on)),
                  ), //Icon
                ),
//Виджет следа самолета               
                TrackAirplane(),
              ],
            );
          })),
//Виджет кнопки
      floatingActionButton: FloatingActionButton(
//Обработка нажатия      
        onPressed: () {
//Обращение флага анимации. Т.е ее запуск и остановка.
          isAnimating = !isAnimating;
         
          if (isAnimating) {
            starAnimation();
            _controllerSpin.repeat();
          } else {
            timer.cancel();
            _controllerSpin.stop();
          }
//Обновление экрана
          setState(() {});
        },
//Иконка кнопки (значок "запуск" и "стоп")     
        child: isAnimating ? Icon(Icons.stop) : Icon(Icons.play_arrow),
      ),
    );
  }
}


