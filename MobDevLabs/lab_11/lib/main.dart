import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'detailfolder.dart';

void main() {
  runApp(MyApp());
}
//Главный класс приложения
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
//Класс домашней страницы
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
//Класс наследующий состояние
class _HomePageState extends State<HomePage> {
  Future<String> createFolderInAppDocDir(String folderName) async {
    
    //Получаем текущую папку приложения
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
   // Каталог документов приложения + имя папки
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      // если папка уже существует, возвращаем путь
      return _appDocDirFolder.path;
    } else {
      // если папка не существует, создать папку и затем вернуть ее путь
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }
//Метод создания папки с введенным значением
  callFolderCreationMethod(String folderInAppDocDir) async {
   
    String actualFileName = await createFolderInAppDocDir(folderInAppDocDir);
    print(actualFileName);
    setState(() {});
  }
//Контроллер добавления новой папки
  final folderController = TextEditingController();
  String nameOfFolder;
  //Функция добавления новой папки
  Future<void> _addDialog() async {
    //Возвращает диалоговое окно с выбором добавления, а также с названием будущей папки
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                'Добавить папку',
                textAlign: TextAlign.left,
              ),
              Text(
                'Введите название папки для добавления',
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return TextField(
                controller: folderController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Введите название папки'),
                onChanged: (val) {
                  setState(() {
                    nameOfFolder = folderController.text;
                    print(nameOfFolder);
                  });
                },
              );
            },
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text(
                'Добавить',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (nameOfFolder != null) {
                  await callFolderCreationMethod(nameOfFolder);
                  getDir();
                  setState(() {
                    folderController.clear();
                    nameOfFolder = null;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            FlatButton(
              color: Colors.redAccent,
              child: Text(
                'Нет',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<FileSystemEntity> _folders;
  //Функция получения текущей директории приложения
  Future<void> getDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    String pdfDirectory = '$dir/';
    final myDir = new Directory(pdfDirectory);
    setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: false);
    });
    print(_folders);
  }
//Описание диалогового окна удаления
  Future<void> _showDeleteDialog(int index) async {
    //Возвращаем диалоговое окно с выбранным значением
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Точно удалить?',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Да'),
              onPressed: () async {
                await _folders[index].delete();
                getDir();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Нет'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
  
    _folders = [];
    getDir();
    super.initState();
  }
//Построитель представления главного окна
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Папка приложения"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addDialog();
            },
          ),
        ],
      ),
      //Тело - сетка
      body: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Material(
            elevation: 6.0,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future: getFileType(_folders[index]),
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData) {
                              FileStat f = snapshot.data;
                              print("file.stat() ${f.type}");
                              if (f.type.toString().contains("file")) {
                                return Icon(
                                  Icons.people,
                                  size: 50,
                                  color: Colors.orange,
                                );
                              } else {
                                //Возвращаем иконку папки
                                return InkWell(                             
                                  child: Icon(
                                    Icons.folder,
                                    size: 50,
                                    color: Colors.orange,
                                  ),
                                );
                              }
                            }
                            return Icon(
                              Icons.file_copy_outlined,
                              size: 100,
                              color: Colors.orange,
                            );
                          }),
                      Text(
                        '${_folders[index].path.split('/').last}',
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      _showDeleteDialog(index);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: _folders.length,
      ),
    );
  }

  Future getFileType(file) {
    return file.stat();
  }
}
