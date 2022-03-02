import 'package:flutter/material.dart';

import 'notification.dart';
import 'secondactivity.dart';
import 'thirdactivity.dart';


void main() {
  runApp(MyApp());
}

// Запуск приложения MyApp
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab05',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
//виджет по умолчанию
      home: MyHomePage(title: 'Лабораторная работа №5. Первый экран'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

/*Key - ключ вызваемого виджета.
Новый виджет будет использоваться для обновления существующего элемента,
только если его ключ совпадает с ключом текущего виджета, связанного с элементом.
super используется для вызова конструктора базового класса */

  final String title;
  @override
//Создает изменяемое состояние для виджета страницы
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//Переменная для текста, который будет обновляться в соответствии с отправленным текстом с второго экрана
  String textFromSecondScreen = 'Тут будет текст с второго экрана';
//Переменная, хранящая введенный пользователь текст
  String? inputTextField;
//Ключ формы
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyMain = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//Создаем экземпляр уведомления
  final Notifications _notifications = Notifications();

//Действия при инициализации
  @override
  void initState() {
    super.initState();
    // инициализация уведомления
    _notifications.initNotifications(); 
  }

//Приватная функция вызова уведомления
  void _pushNotification({
    String? title = 'Незаданный заголовок',
    String? body = "Незаданное тело уведомления",
  }) {
    _notifications.pushNotification(
        title: title!, body: body!); // вызов уведомления
  }

//Функция ожидания введенного значения с второй активити
  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    //Открытие второго экрана и ожидание возвращаемого значения
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(),
        ));

    //После возвращения текста с второго экрана, обновляем текущий экран и перерисовываем виджет текста
    setState(() {
      if(result!=null)
      textFromSecondScreen = result;
    });
  }
//Функция отправки значения с главного экрана на третью активити
  void _pushValueToThirdScreen(BuildContext context, String pushString) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThirdScreen(
            textOnThirdScreen: pushString,
          ),
        ));
  }
//Функция диалогового окна
  Future<void> showInformationDialog(BuildContext context) async {
    //Стартовое значение слайдера
    double _currentSliderValue = 20;
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Яркость'),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [],
                  )),
              actions: <Widget>[
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text(
                        'Отмена',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                        child: Text(
                          'ОК',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          _pushNotification(
                              title: 'Уведомление о выбранной яркости',
                              body:
                                  'Вы выбрали значение: ${_currentSliderValue.toString()}');
                        }),
                  ],
                ),
              ],
            );
          });
        });
  }

// виджет создания контекста
//Описывает часть пользовательского интерфейса, представленную этим виджетом
  @override
  Widget build(BuildContext context) {
//Виджет текстового поля
    Widget _textInputField() {
      return TextFormField(
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          filled: true,
          hintText: 'Введите текст',
          labelText: 'Текстовое поле',
          icon: const Icon(Icons.text_fields),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        validator: (value) {
//Валидация поля ввода. Если не пустое, то добавляется в список
          if (value == null || value.isEmpty) {
            return "Вы не ввели текст!";
          }
          return null;
        },
        onSaved: (string) {
          inputTextField = string;
        },
      );
    }

//Виджет пустого пространства (для отделения виджетов)//
    const spaceBoxHight = SizedBox(
      height: 15,
    );

//Основной экран
    return MaterialApp(
        home: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyMain,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
 //Кнопка вызова диалогового окна
                ElevatedButton(
                    onPressed: () async {
                      await showInformationDialog(context);
                    },
                    child: Text(
                      "Показать диалог",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                spaceBoxHight,
 //Текст, в который вернется введеный пользователем текст с второй активити
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    textFromSecondScreen,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                spaceBoxHight,
 //Кнопка вызова втоорого активити
               ElevatedButton(
                    onPressed: () {
                      _awaitReturnValueFromSecondScreen(context);
                    },
                    child: Text('К второму экрану')),
                spaceBoxHight,
 //Текстовое поле ввода             
                _textInputField(),
                spaceBoxHight,
 //Кнопка вызова подсказки                
                ElevatedButton(
                    onPressed: () {
                      if (_formKeyMain.currentState!.validate()) {
                        _formKeyMain.currentState!.save();
                        _scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Text(
                            'Подсказка: $inputTextField',
                          ),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: Text('Показать подсказку из введенного текста')),
                spaceBoxHight,
  //Кнопка отправки текста на третий экран                
                ElevatedButton(
                    onPressed: () {
                      if (_formKeyMain.currentState!.validate()) {
                        _formKeyMain.currentState!.save();
                        _pushValueToThirdScreen(context, inputTextField!);
                      }
                    },
                    child: Text('Отправить введенный текст на третий экран')),               
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
