import 'package:lab_06/firstfragment.dart';
import 'package:flutter/material.dart';
import 'package:lab_06/secondfragment.dart';
import 'package:lab_06/stringProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>StringDrop()) ],
    child: MyApp(),
  ));
}

// Запуск приложения MyApp
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа №6',
      home: MyHomePage(
        title: 'Лабораторная работа №6',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key,  this.title}) : super(key: key);
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
  int _currentIndex = 0;
  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: <Widget>[
          FirstFragmentWidget(),
          SecondFragmentWidget(
            textFromFirst: FirstFragmentWidget.textL ?? '',
          ),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          currentIndex: _currentIndex,
          onTap: _onTapped,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Фрагмент 1',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.text_fields),
              label: 'Фрагмент 2',
            ),
          ],
        ));
  }
}
