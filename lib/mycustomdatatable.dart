import 'addDialog.dart';
import 'textDialog.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class mycustomdatatable extends StatefulWidget {
  
  mycustomdatatable(this.columns, this.data,
      {this.minwidth: 0, this.sortColumnIndex: 0, this.isAscending: true}) {
    String key = columns.keys.toList()[sortColumnIndex];
    sortString(key, isAscending, data);
  }

  Map<String, dynamic> columns;
  List<Map<String, dynamic>> data;
  double minwidth;
  bool isAscending;
  int sortColumnIndex;

  @override
  State<mycustomdatatable> createState() => _mycustomdatatableState();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _mycustomdatatableState extends State<mycustomdatatable> {
  final formkey = GlobalKey<FormState>();
  bool isAscending = true;
  int sortColumnIndex = 0;
  List<Map<String, dynamic>> selrows = [];
  late List<String> columns;

  @override
  void initState() {
    super.initState();
    columns = widget.columns.keys.toList();
    isAscending = widget.isAscending;
    sortColumnIndex = widget.sortColumnIndex;
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                    minWidth: widget.minwidth,
                    maxWidth: max(screenwidth, widget.minwidth)),
                width: double.infinity,
                child: buildDataTable(),
              ),
            )),
        floatingActionButton: selrows.length > 0
            ? FloatingActionButton(
                onPressed: (() async {
                  setState(() {
                    selrows.forEach((element) {
                      widget.data.remove(element);
                    });
                    selrows.clear();
                  });
                }),
                child: Icon(Icons.delete),
                backgroundColor: Colors.red,
              )
            : FloatingActionButton(
                onPressed: (() async {
                  await addDialog(context,
                          title: "Add row", columns: widget.columns)
                      .then((value) {
                    if (value != false) {
                      setState(() {
                        widget.data.add(value);
                      });
                    }
                  });
                }),
                child: Icon(Icons.add),
                backgroundColor: Colors.grey,
              ),
      ),
    );
  }

  Widget buildDataTable() {
    return DataTable(
      headingRowColor:
          MaterialStateProperty.resolveWith((states) => Colors.grey),
      columnSpacing: 10,
      horizontalMargin: 100,
      showBottomBorder: true,
      dividerThickness: 2.0,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(widget.data),
    );
  }

  void onSort(int columnIndex, bool ascending) {
    String key = this.columns[columnIndex];
    sortString(key, ascending, widget.data);

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        onSort: onSort,
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Map<String, dynamic>> data) =>
      data.map((Map<String, dynamic> row) {
        return DataRow(
            selected: selrows.contains(row),
            onSelectChanged: (val) {
              onselectrow(val!, row);
            },
            cells: columns.map((key) {
              dynamic val=row.containsKey(key)?row[key]:"";
              return DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        val.toString(),
                      ),
                      IconButton(
                          splashRadius: 16,
                          onPressed: () {
                            editValue(val).then((value) {
                              if (value != false &&
                                  value.toString() != val.toString()) {
                                setState(() {
                                  row[key] = value;
                                });
                              }
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 16,
                          ))
                    ],
                  ),
                  showEditIcon: false);
            }).toList());
      }).toList();

  Future editValue(String value) async {
    return await textDialog(
      context,
      title: 'Edit Value',
      value: value,
    );
  }

  void onselectrow(bool val, Map<String, dynamic> row) async {
    setState(() {
      if (val) {
        selrows.add(row);
      } else {
        selrows.remove(row);
      }
    });
  }
}

void sortString(String key, bool ascending, List<Map<String, dynamic>> data) {
  data.sort((row1, row2) => ascending
      ? row1[key].toString().compareTo(row2[key].toString())
      : row2[key].toString().compareTo(row1[key].toString()));
}
