import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:controlpul/dao/PiscinaDao.dart';
import 'package:controlpul/constantes.dart';
import 'package:controlpul/views/PiscinaForm.dart';
import 'FichaPiscinaView.dart';

class PiscinasView extends StatefulWidget {
  @override
  PiscinasViewState createState() => PiscinasViewState();
}

class PiscinasViewState extends State<PiscinasView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Piscinas')),
        body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: aniadirPiscina,
                  child: const Text('Añadir piscina'),
                ),
                formSpacer,
                Text("Mis piscinas"),
                formSpacer,
                Expanded(
                  child: FutureBuilder<List<PiscinaDao>>(
                      future: getPiscinas(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {} else
                        if (snapshot.data != null) {}
                        return snapshot.hasData
                            ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder:
                                (BuildContext context, int index) =>
                                elementoPiscina(snapshot.data![index]))
                            : const Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            )));
  }

  Widget elementoPiscina(PiscinaDao dao) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FichaPiscinaView(piscinaDato: dao),
            ));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(fit: BoxFit.fitWidth,
                  image: AssetImage('images/piscina_demo.jpeg'),
                  height: 80,
                  width: 150,
                ),
                SizedBox(width: 8,),
                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Titulo(dao.nombre,), Text(dao.direccion),

                    Row(children: [Spacer(),
                      Text("Última medición:")],)
                  ],
                ))

              ]),
        ),
      ),
    );
  }

  void aniadirPiscina() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PiscinaForm(),
        ));
  }

  Future<List<PiscinaDao>> getPiscinas() async {
    List<dynamic> data = await supabase.from('piscinas').select();
    print("");
    List<PiscinaDao> datos = [];
    if (data != null) {
      for (int i = 0; i < data!.length; i++) {
        PiscinaDao piscinaDao = PiscinaDao();
        piscinaDao.id = data[i]["id"];
        piscinaDao.nombre = data[i]["alias"];
        piscinaDao.direccion = data[i]["direccion"];
        piscinaDao.cp = data[i]["cp"];
        datos.add(piscinaDao);
      }
    }

    return datos;
  }
}
