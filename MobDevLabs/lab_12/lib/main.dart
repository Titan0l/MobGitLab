import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Запуск приложения MyApp
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab12',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //виджет по умолчанию
      home: MyHomePage(title: 'Лабораторная работа №12'),
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
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // Создание таймера
  late Timer timer1;
  late Timer timer2;
  late Timer timer3;
  //Создание цветов флага
  var color1 = Colors.red;
  var color2 = Colors.red;
  var color3 = Colors.red;
//Функции запуска таймеров
  void starAnimation1() {
    // Таймер повторения действий
    timer1 = Timer.periodic(Duration(seconds: 1), (_) {
      //Обновление экрана
      setState(() {
        if (color1 == Colors.red) {
          color1 = Colors.green;
        } else {
          color1 = Colors.red;
        }
      });
    });
  }

  void starAnimation2() {
    // Таймер повторения действий
    timer2 = Timer.periodic(Duration(seconds: 2), (_) {
      //Обновление экрана
      setState(() {
        if (color2 == Colors.red) {
          color2 = Colors.green;
        } else {
          color2 = Colors.red;
        }
      });
    });
  }

  void starAnimation3() {
    // Таймер повторения действий
    timer3 = Timer.periodic(Duration(seconds: 3), (_) {
      //Обновление экрана
      setState(() {
        if (color3 == Colors.red) {
          color3 = Colors.green;
        } else {
          color3 = Colors.red;
        }
      });
    });
  }
//Действия при инициализации
  @override
  void initState() {
    super.initState();
    starAnimation1();
    starAnimation2();
    starAnimation3();
  }

  // виджет создания контекста
  //Описывает часть пользовательского интерфейса, представленную этим виджетом
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: color1,
                child: SizedBox(height: 50,width: 50,),
              ),
              Container(
                color: color2,
                child: SizedBox(height: 50,width: 50,),
              ),
              Container(
                color: color3,
                child: SizedBox(height: 50,width: 50,),
              ),
              ElevatedButton(
                  onPressed: () {
                    _showOKDialog();
                  },
                  child: Text('Тест')),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _showOKDialog() async {
    //Возвращаем диалоговое окно с выбранным значением
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Все ОК. возвращаемся назад?',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Да'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
