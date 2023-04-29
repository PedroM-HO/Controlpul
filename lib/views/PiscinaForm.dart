import 'package:controlpul/views/RegistroForm.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:controlpul/dao/PiscinaDao.dart';
import 'package:controlpul/constantes.dart';

class PiscinaForm extends StatefulWidget {
  @override
  PiscinaFormState createState() => PiscinaFormState();
}

class PiscinaFormState extends State<PiscinaForm> {
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _cpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva piscina')),
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(children: [
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre piscina'),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 12,),
          TextFormField(
            controller: _direccionController,
            decoration: const InputDecoration(labelText: 'Dirección'),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 12,),
          TextFormField(
            controller: _cpController,
            decoration: const InputDecoration(labelText: 'C.P.'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12,),
          

          ElevatedButton(
            onPressed: registrarPiscina,
            child: const Text('Añadir piscina'),
          ),
        ]),
      ),
    );
  }

  void registrarPiscina() async {
    try {
      await supabase.from('piscinas').insert({
        'owner_id': "a912c234-e966-41e8-96d0-85a7b1e58784",
        'alias': _nombreController.text,
        'direccion': _direccionController.text,
        'cp': _cpController.text,
      });

      Navigator.pop(context);
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }
  

}
