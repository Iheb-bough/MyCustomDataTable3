import 'package:flutter/material.dart';

Future addDialog(BuildContext context,{
required String title, required Map<String,dynamic> columns,Map<String, dynamic>? default_values,
}) async {
  final formkey=GlobalKey<FormState>();

  return await showDialog(context: context,
      builder: (context){
        Map<String,TextEditingController> _textEditingController=Map();
        columns.forEach((key, value) {
          _textEditingController[key]=TextEditingController();
          if(default_values!=null) _textEditingController[key]!.text=default_values[key];
        });
        return StatefulBuilder(builder: (context,setState){
          return AlertDialog(
            title: Text(title),
            content: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                    columns.entries.map((col) => Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        validator:  (value) {
                          if(value!.length<2){return 'enter at least two characters';
                          } else  {return null;}
                        },
                        controller: _textEditingController[col.key],
                        textInputAction:TextInputAction.done ,
                        decoration: InputDecoration(hintText: col.key, border: OutlineInputBorder()),
                      ),
                    )).toList(),
                ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  child: Text('Cancel'),
                  onPressed: () {Navigator.of(context, rootNavigator: true).pop(false);}
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  child: Text('Done'),
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                      //formkey.currentState!.save();
                      Map<String,dynamic> newValues=Map();
                      columns.forEach((key, value) {
                        newValues[key]=_textEditingController[key]!.text;
                      });
                      Navigator.of(context, rootNavigator: true).pop(newValues);
                    }
                  }
              ),
            ],
          );
        });
      });
}