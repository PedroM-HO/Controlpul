import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'datepicker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:controlpul/constantes.dart';
import 'package:controlpul/dao/RegistroDao.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:controlpul/download.dart';

class DetalleHistoricoView extends StatefulWidget {
  List<RegistroDao> list;

  DetalleHistoricoView({Key? key, required this.list}) : super(key: key);

  @override
  DetalleHistoricoViewState createState() => DetalleHistoricoViewState();
}

class DetalleHistoricoViewState extends State<DetalleHistoricoView> {
  late MisFilas filas;

  @override
  void initState() {
    super.initState();
    filas = MisFilas(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles historico'),
        actions: [IconButton(
          icon: Icon(Icons.download_for_offline),
          onPressed: () {
            generateCSV();
          },
        ),],
      ),
      body: Column(children: [
        Text("Datos"),
        PaginatedDataTable(sortAscending: true,columns: [
          DataColumn(label: Text("Fecha")),
          DataColumn(label: Text("Ph")),
          DataColumn(label: Text("Cloro residual")),
          DataColumn(label: Text("Cloro Combinado")),
          DataColumn(label: Text("Ácido"))
        ], source: filas)
      ]),
    );
  }

  void generateCSV() async{
    List<List<String>> data = [
      ["Fecha.", "PH", "Cloro Residual", "Cloro Combinado", "Ácido"],
    ];


    for(int i=0;i<widget.list.length;i++){
      var elementoList = widget.list[i];
      data.add([elementoList.fecha,elementoList.ph.toString(),elementoList.cloro_residual.toString(),elementoList.cloro_combinado.toString(),elementoList.acido_isocianurico.toString()]);
    }
    String csvData = ListToCsvConverter().convert(data);
   // File myFile = File('mifile.csv');

    download(csvData.codeUnits, // takes bytes
        downloadName: 'excelm.csv');
  }
}

void _launchURL(url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

class MisFilas extends DataTableSource {
  late List<RegistroDao> list;

  MisFilas(List<RegistroDao> list) {
    this.list = list;
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(list[index].fecha)),
      DataCell(Text(list[index].ph.toString())),
      DataCell(Text(list[index].cloro_residual.toString())),
      DataCell(Text(list[index].cloro_combinado.toString())),
      DataCell(Text(list[index].acido_isocianurico.toString()))
    ]);
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return list.length;
  }
}
