import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab_06/stringProvider.dart';
class FirstFragmentWidget extends StatefulWidget {
  const FirstFragmentWidget({Key key}) : super(key: key);
static String textL;
  @override
  _ListWidget createState() => _ListWidget();
}

class _ListWidget extends State<FirstFragmentWidget> {
  
//Переменная, хранящая введенный пользователь текст
  String inputTextField;

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
          icon: const Icon(Icons.input),
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
          FirstFragmentWidget.textL = string;
          context.read<StringDrop>().textDrop= string;
        },
      );
    }


//Контроллер текстового поля
final TextEditingController _textFieldController = TextEditingController();
//Ключ формы 
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
             Padding(
                padding: const EdgeInsets.all(32.0),
                child: _textInputField(),
              ),
              ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        _formkey.currentState.save();
                        
                        
                        //_pushValueToThirdScreen(context, inputTextField!);
                      }
                    },
                    child: Text('Отправить введенный текст в фрагмент 2')),   
          ],
        ),
      ),
    );
  }
}
