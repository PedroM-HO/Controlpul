import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:controlpul/views/datepicker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:controlpul/constantes.dart';
import 'package:controlpul/dao/RegistroDao.dart';
import 'package:controlpul/views/DetalleHistoricoView.dart';
//import 'package:csv/csv.dart';

class HistoricoView extends StatefulWidget {
  @override
  HistoricoViewState createState() => HistoricoViewState();
}

class HistoricoViewState extends State<HistoricoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: FutureBuilder<List<RegistroDao>>(
          future: getHistorico(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
            } else if (snapshot.data != null) {}
            return snapshot.hasData
                ? cuerpo(snapshot.data!)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<List<RegistroDao>> getHistorico() async {
    List<dynamic> data = await supabase.from('registro_piscina').select();
    print("");
    List<RegistroDao> datos = [];
    if (data != null) {
      for (int i = 0; i < data!.length; i++) {
        RegistroDao registroDao = RegistroDao();
        registroDao.ph = data[i]["ph"] ?? 0.0;
        registroDao.cloro_residual = data[i]["cloro_res"] ?? 0.0;
        registroDao.cloro_combinado = data[i]["cloro_com"] ?? 0.0;
        registroDao.acido_isocianurico = data[i]["acido"] ?? 0.0;
        registroDao.fecha = data[i]["created_at"] ?? "";

        datos.add(registroDao);
      }
    }

    return datos;
  }

  Widget cuerpo(List<RegistroDao> datos) {
    return ListView.builder(
        itemCount: datos.length,
        itemBuilder: (BuildContext context, int index) =>
            elementoHistorico(datos[index],datos));
  }

  Widget elementoHistorico(RegistroDao regis,List<RegistroDao> datos) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalleHistoricoView(list:datos),
              ));

        },
        child: Card(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Fecha ${regis.fecha}"),
                ],
              )),
        ));
  }
}
