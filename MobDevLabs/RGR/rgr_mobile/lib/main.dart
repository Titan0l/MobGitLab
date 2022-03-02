import 'dart:math';
import 'package:flutter/material.dart';
//Главная функция
void main() {
  runApp(MyApp());
}

// Запуск приложения MyApp
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LabRGR',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //виджет по умолчанию
      home: MyHomePage(title: 'РГР'),
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

class _MyHomePageState extends State<MyHomePage> {
  //экземпляр класса случайных чисел и два числа, в которых будет храниться выпавшее число
  Random random = new Random();
  late int random_number1;
  late int random_number2;
//Инициализация  переменных
  @override
  void initState() {
    random_number1 = random.nextInt(5) + 1;
    random_number2 = random.nextInt(5) + 1;
    super.initState();
  }

  @override
  // виджет создания контекста
  //Описывает часть пользовательского интерфейса, представленную этим виджетом
  Widget build(BuildContext context) {
    //Основное дерево виджетов компановки экрана
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //Контейнер с зеленым фоном
      body: Container(
        alignment: Alignment.center,
        color: Colors.green.shade200,
        //Виджет считывания нажатий на экран ( в данном случае тап)
        child: GestureDetector(
          onTap: () {
            setState(() {
              random_number1 = random.nextInt(5) + 1;
              random_number2 = random.nextInt(5) + 1;
            });
          },
          //Виджет выравнивания в колону
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Виджет первого кубика с анимацией вращения
             Expanded(
                  child: Transform.rotate(
                angle: pi*random_number1*0.6, 
                child: Image.asset("assets/images/$random_number1.png"),
              )),
              //Виджет второго кубика с анимацией вращения
              Expanded(
                  child: Transform.rotate(
                angle: pi*random_number2*0.2, 
                child: Image.asset("assets/images/$random_number2.png"),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
