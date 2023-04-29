import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:controlpul/views/datepicker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:controlpul/constantes.dart';
import 'package:controlpul/dao/PiscinaDao.dart';
import 'package:controlpul/valores.dart';

class RegistroForm extends StatefulWidget {
  PiscinaDao piscinaDato;

  RegistroForm({Key? key, required this.piscinaDato}) : super(key: key);

  @override
  RegistroFormState createState() => RegistroFormState();
}

class RegistroFormState extends State<RegistroForm> {
  final _phController = TextEditingController();
  final _clororesController = TextEditingController();
  final _cloroCombController = TextEditingController();
  final _acidoController = TextEditingController();
  final _bromoController = TextEditingController();

  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Datos piscina')),
        body: Column(children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              TimePicker();
                            },
                            child: const Text('Hora'),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            child: DatePicker(),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _phController,
                        decoration: const InputDecoration(labelText: 'PH'),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _clororesController,
                        decoration:
                            const InputDecoration(labelText: 'Cloro Residual'),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _cloroCombController,
                        decoration:
                            const InputDecoration(labelText: 'Cloro Combinado'),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _acidoController,
                        decoration: const InputDecoration(
                            labelText: 'Ácido Isocianuro'),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CampoPiscinaValidador(labelText: "Bromo", controller:_bromoController,
                          type:TextInputType.number, conjuntosValores:valoresBromo),
                    ],
                  ))),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: guardaRegistro,
              child: const Text('Registrar'),
            ),
          )
        ]));
  }

  void TimePicker() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  // Widget CampoPiscinaValidador(
  //     String labelText,
  //     TextEditingController controller,
  //     TextInputType type,
  //     ConjuntosValores conjuntosValores) {
  //   int iconState = -1;
  //
  //   return Container(
  //     child: Row(children: [
  //       Expanded(
  //         flex: 3,
  //         child: TextFormField(
  //           controller: controller,
  //           decoration: InputDecoration(labelText: labelText),
  //           keyboardType: type,
  //           onChanged: (value) {
  //             if (value.isNotEmpty && double.tryParse(value) != null) {
  //               var parse = double.parse(value);
  //               if (conjuntosValores.valoresOptimos.min >= parse &&
  //                   conjuntosValores.valoresOptimos.max <= parse) {
  //                 iconState = 1;
  //               } else if (conjuntosValores.valoresAviso.min >= parse &&
  //                   conjuntosValores.valoresAviso.max <= parse) {
  //                 iconState = 2;
  //               }
  //             }
  //           },
  //         ),
  //       ),
  //       Visibility(
  //           visible: iconState != -1,
  //           child: Expanded(
  //             flex: 1,
  //             child: Icon(
  //               Icons.warning,
  //               color: iconState == 1 ? Colors.green : Colors.red,
  //             ),
  //           ))
  //     ]),
  //   );
  // }

  void guardaRegistro() async {
    try {
      await supabase.from('registro_piscina').insert({
        'user_id': "a912c234-e966-41e8-96d0-85a7b1e58784",
        'id_piscina': widget.piscinaDato.id,
        'ph': double.parse(_phController.text),
        'cloro_res': double.parse(_clororesController.text),
        'cloro_com': double.parse(_cloroCombController.text),
        'acido': double.parse(_acidoController.text),
      });
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }
}

class CampoPiscinaValidador extends StatefulWidget {
  String labelText; TextEditingController controller; TextInputType type;ConjuntosValores conjuntosValores;

  CampoPiscinaValidador({Key? key, required this.labelText,required this.controller,required this.type, required this.conjuntosValores}) : super(key: key);

  @override
  CampoPiscinaValidadorState createState() => CampoPiscinaValidadorState();
}

class CampoPiscinaValidadorState extends State<CampoPiscinaValidador> {
  late int iconState;
  @override
  void initState() {
    super.initState();
    iconState = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(labelText: widget.labelText),
            keyboardType: widget.type,
            onChanged: (value) {
              if (value.isNotEmpty && double.tryParse(value) != null) {
                var parse = double.parse(value);
                if (widget.conjuntosValores.valoresOptimos.min >= parse &&
                    widget.conjuntosValores.valoresOptimos.max <= parse) {

                  setState(() {
                    iconState = 1;
                  });

                } else if (widget.conjuntosValores.valoresAviso.min >= parse &&
                    widget.conjuntosValores.valoresAviso.max <= parse) {

                  setState(() {
                    iconState = 2;
                  });

                }
              }
            },
          ),
        ),
        Text("$iconState"),
        Visibility(
            child: Expanded(
              flex: 1,
              child: Icon(
                Icons.warning,
                color: iconState == 1 ? Colors.green : Colors.red,
              ),
            ))
      ]),
    );
  }
}
