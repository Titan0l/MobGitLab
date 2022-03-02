
import 'package:flutter/material.dart';
//Класс второго активити
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);
  @override
  _SecondScreenState createState() {
    return _SecondScreenState();
  }
}
class _SecondScreenState extends State<SecondScreen> {
  // Переменная доступа к контроллеру текстового поля для отправки его значения на первый экран
  TextEditingController textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text('Второй экран')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: textFieldController,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
//Кнопка отправки текста на предыдущий экран            
            ElevatedButton(
              child: Text(
                'Отправить текст на первый экран',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                _sendDataBack(context);
              },
            ),
            
          ],
        ),
      ),
    );
  }

//Функция отправки данных обратно
  void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    Navigator.pop(context, textToSendBack);
  }
}
