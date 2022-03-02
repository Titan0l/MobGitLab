import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab_06/stringProvider.dart';
class SecondFragmentWidget extends StatefulWidget {
  final  String textFromFirst;
  const SecondFragmentWidget({Key key,  this.textFromFirst,}) : super(key: key);

  @override
  _ListWidget createState() => _ListWidget();
}

class _ListWidget extends State<SecondFragmentWidget> {

TextEditingController textFieldController = TextEditingController();

@override
  void initState() {
     textFieldController.text = widget.textFromFirst;

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: <Widget>[
           Padding(           
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                cursorColor: Colors.red,
                controller: textFieldController,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            Text(widget.textFromFirst),
            Text(context.watch<StringDrop>().textDrop),
        ],
      ),
    );
  }
}
