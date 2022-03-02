import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart' show Colors;
void main() {
  runApp(MyApp());}
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

  MyHomePage({Key key, this.title}) : super(key: key);

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

//флаг переключения размера между кнопками.
bool switchFlag =false;
//стиль 1 кнопки
ButtonStyle style1 = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15) , primary: Colors.orange, minimumSize: Size(50, 80) );
//стиль 2 кнопки
  ButtonStyle style2 = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15) , primary: Colors.blue, minimumSize: Size(10, 30));
//функция обработки нажатия на кнопки и изменения состояния виджетов
  void _switchSize() {
    setState(() {
      switchFlag=!switchFlag;
      if(switchFlag==true){
      style1 = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15) , primary: Colors.blue, minimumSize: Size(10, 30));
      style2 = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15) , primary: Colors.orange, minimumSize: Size(50, 80));}
      else {
       style1 = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15) , primary: Colors.orange, minimumSize: Size(50, 80) );
       style2 = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15) , primary: Colors.blue, minimumSize: Size(10, 30));
      }
    });
  }

  @override
  // виджет создания контекста
  //Описывает часть пользовательского интерфейса, представленную этим виджетом
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),),

          body: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text('Нажмите на кнопку, чтобы поменять их размер местами',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0 ),
                  textAlign: TextAlign.center,


                ),

                const SizedBox(height: 30,),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      ElevatedButton(
                        onPressed: _switchSize,
                        style: style1 ,
                        child: Text('Кнопка №1'),
                      ),

                      const SizedBox(width: 30,),

                      ElevatedButton (
                        onPressed: _switchSize,
                        style: style2 ,
                        child: Text('Кнопка №2'),
                      ),
                    ] )
              ],
            ),

          ),
        )
    );
  }
}
