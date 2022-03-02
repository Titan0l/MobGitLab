import 'package:flutter/material.dart';

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
      title: 'Lab01',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
//виджет по умолчанию
      home: MyHomePage(title: 'Лабораторная работа №4'),
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

//Флаг чекбокса
  bool _valueCheckBox = true;

// Список значений левого списка
  List<String> list1 = <String>[
    'Рыжик',
    'Барсик',
    'Мурзик',
    'Васька',
  ];

// Список значений правого списка
  List<String> list2 = <String>[
    'Шарик',
    'Барбос',
    'Барбос',
  ];
//Ключ формы
  final _formKey = GlobalKey<FormState>();

  @override
// виджет создания контекста
//Описывает часть пользовательского интерфейса, представленную этим виджетом
  Widget build(BuildContext context) {
//Описание виджета текстового поля
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
//Условие добавления в список. Если флаг активен - в левое, иначе в правое
          if (_valueCheckBox == false) {
            list1.add(string!);
          } else {
            list2.add(string!);
          }
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                //Виджет текстового поля
                Align(
                    alignment: Alignment.centerLeft, child: _textInputField()),
                spaceBoxHight,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//Виджет левого списка
                    Expanded(
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: list1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            color: Colors.blue,
                            child: Center(child: Text('${list1[index]}')),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
//Виджет левого списка
                    Expanded(
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: list2.length,
                        itemBuilder: (BuildContext context, int index2) {
                          return Container(
                            height: 50,
                            color: Colors.orange,
                            child: Center(child: Text(list2[index2])),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index2) =>
                            const Divider(),
                      ),
                    ),
                  ],
                ),
//Виджеты чекбокса, текста, кнопки
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Checkbox(
                          value: _valueCheckBox,
                          onChanged: (bool? value) {
                            setState(() {
                              _valueCheckBox = value!;
                            });
                          }),
                    ),
                    Text('Правый список'),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
//Перерисовка окна, обновление состояния
                            setState(() {});
                          },
                          child: Text('Добавить в список')),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
