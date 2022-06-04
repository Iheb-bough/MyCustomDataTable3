import 'package:flutter/material.dart';
import 'mycustomdatatable.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Custom Data Table',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Custom Data Table'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String columns_json =
      '{"First Name":"String", "Last Name":"String", "Age":"int"}';
  String data_json = '['
      '{"First Name": "iheb", "Last Name": "boughrassa", "Age":21 },'
      '{"First Name": "farid", "Last Name": "sarni", "Age": 21},'
      '{"First Name": "alaa", "Last Name": "dehbi", "Age": 21},'
      '{"First Name": "mustapha", "Last Name": "mehessim", "Age": 22},'
      '{"First Name": "amine", "Last Name": "sersar", "Age": 19},'
      '{"First Name": "raouf", "Last Name": "hadji", "Age": 19},'
      '{"First Name": "yacine", "Last Name": "khadir", "Age": 21},'
      '{"First Name": "lilia", "Last Name": "tamine", "Age": 21},'
      '{"First Name": "chihez", "Last Name": "benladj", "Age": 21},'
      '{"First Name": "aya", "Last Name": "miloua", "Age": 21},'
      '{"First Name": "aymen", "Last Name": "goual", "Age": 20},'
      '{"First Name": "hadi", "Last Name": "nedir", "Age": 23},'
      '{"First Name": "issam", "Last Name": "nedir", "Age": 19},'
      '{"First Name": "reda ", "Last Name": "metref", "Age": 21},'
      '{"First Name": "chakib", "Last Name": "mesli", "Age": 21},'
      '{"First Name": "remzi", "Last Name": "ezzine", "Age": 23},'
      '{"First Name": "salim", "Last Name": "farddheb", "Age": 21},'
      '{"First Name": "amine", "Last Name": "bouhafssi", "Age": 20}'
      ']';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> columns = jsonDecode(columns_json);
    List<Map<String, dynamic>> data = (jsonDecode(data_json) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    return SafeArea(
      child: mycustomdatatable(
        columns,
        data,
        minwidth: 600,
      ),
    );
  }
}
