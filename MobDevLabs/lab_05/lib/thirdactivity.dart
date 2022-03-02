import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  final String textOnThirdScreen;
  //Конструктор класса с передаваемым значением
  const ThirdScreen({Key? key, required this.textOnThirdScreen})
      : super(key: key);
  @override
  _ThirdScreenState createState() {
    return _ThirdScreenState();
  }
}

class _ThirdScreenState extends State<ThirdScreen> {
  // this allows us to access the TextField text
  TextEditingController textFieldController = TextEditingController();
//String textOnSecondScreen ='Текст с первого экрана';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(title: Text('Третий экран')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Введенный текст с первого экрана: ${widget.textOnThirdScreen}',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
