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
      home: MyHomePage(title: 'Лабораторная работа №2: Layout Demo'),
    );
  }
}

//Т.к мы не обрабатываем нажатия, то создаем класс виджетов без состояния
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  //Key - ключ вызваемого виджета.
  // Новый виджет будет использоваться для обновления существующего элемента,
  // только если его ключ совпадает с ключом текущего виджета, связанного с элементом.

  //super используется для вызова конструктора базового класса

  final String title;
  @override
  // виджет создания контекста
  //Описывает часть пользовательского интерфейса, представленную этим виджетом

  @override
  Widget build(BuildContext context) {
    //Виджет пустого пространство по ширине в 10 пикселей
    const _sizedBoxWith = SizedBox(
      width: 10,
    );
    //Виджет пустого пространство по высоте в 10 пикселей
    const _sizedBoxHight = SizedBox(
      height: 10,
    );

    //Виджет маленького текста
    Widget _smallText() => const Text(
          "Small Text",
          style: TextStyle(fontSize: 14),
        );

    //Виджет кнопки
    Widget _button(String textButton) => ElevatedButton(
        onPressed: () {},
        child: Text(
          textButton,
          style: TextStyle(fontSize: 17),
        ));

//Виджет большого текста
    Widget _largeText() => const Text(
          "Large Text",
          style: TextStyle(fontSize: 25),
        );

    //Виджет строки с тремя виджетами маленького текста
    Widget _rowOfSmallText() =>
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          _smallText(),
          _sizedBoxWith,
          _smallText(),
          _sizedBoxWith,
          _smallText()
        ]);

    //Виджет строки с тремя виджетами кнопки
    Widget _rowOfButtons() =>
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          _button("Button"),
          _sizedBoxWith,
          _button("Button"),
          _sizedBoxWith,
          _button("Button")
        ]);
    //Виджет строки с тремя виджетами кнопки
    Widget _columnOfButtons() => Align(
          alignment: Alignment.centerRight,
          child: Column(children: <Widget>[
            _button("Button"),
            _sizedBoxHight,
            _button("Button"),
            _sizedBoxHight,
            _button("Go"),
            _sizedBoxHight,
          ]),
        );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _rowOfSmallText(),
              _rowOfButtons(),
              _largeText(),
              _columnOfButtons(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                _largeText(),
                Align(alignment: Alignment.centerRight, child: _button("Button")),
                
              ])
            ],
          ),
        ),
      ),
    );
  }
}
