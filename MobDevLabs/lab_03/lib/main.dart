import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart' show Colors;

void main() {
  runApp(MyApp());
}

// Запуск приложения MyApp
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab01',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //виджет по умолчанию
      home: MyHomePage(title: 'Лабораторная работа №1'),
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
  String titleChange = 'Заголовок до нажатия';

  final GlobalKey _menuKey = new GlobalKey();

  void changeText() {
    setState(() {
      titleChange = 'Была нажата кнопка home';
    });
  }

  @override
  // виджет создания контекста
  //Описывает часть пользовательского интерфейса, представленную этим виджетом
  Widget build(BuildContext context) {
    Widget _popupMenu() => PopupMenuButton(
        key: _menuKey,
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(child: const Text('Элемент 1'), value: 'Элемент 1'),
              PopupMenuItem<String>(child: const Text('Элемент 2'), value: 'Элемент 2'),
            ],
        onSelected: (selectionResult) {
          setState(() {
            titleChange = selectionResult.toString();
          });
        });

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(titleChange),
        leading:
            IconButton(onPressed: changeText, icon: Icon(Icons.arrow_back_ios)),
        actions: <Widget>[
          _popupMenu(),
        ],
      ),
      body: Center(),
    ));
  }
}
