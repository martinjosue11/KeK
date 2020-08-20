import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:materias_dos/src/models/datos_materias.dart';

class DatosMateriasPage extends StatefulWidget {
  @override
  _DatosMateriasPageState createState() => _DatosMateriasPageState();
}

class _DatosMateriasPageState extends State<DatosMateriasPage> {
  List<MateriaDatos> _datosM = List<MateriaDatos>();

  Future<List<MateriaDatos>> fetchMateria() async {
    var url = 'http://148.202.89.11/api_spasa/info_materia/108304';
    var response = await http.get(url);

    var datosM = List<MateriaDatos>();

    if (response.statusCode == 200) {
      var materias = json.decode(response.body);
      for (var materia in materias) {
        datosM.add(MateriaDatos.fromJson(materia));
      }
    }
    return datosM;
  }

  @override
  void initState() {
    fetchMateria().then((value) {
      setState(() {
        _datosM.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Materias'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Aula: " + _datosM[index].aula.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Divider(),
                Text("Dia: " + _datosM[index].dia.toString(),
                    style: TextStyle(fontSize: 18)),
                Divider(),
                Text("Hora de Inicio: " + _datosM[index].hora_inicio.toString(),
                    style: TextStyle(fontSize: 18)),
                Divider(),
                Text("Hora Fin: " + _datosM[index].hora_fin.toString(),
                    style: TextStyle(fontSize: 18)),
                Divider(),
                Text("CRN: " + _datosM[index].crn.toString(),
                    style: TextStyle(fontSize: 18)),
                Divider(),
                Text("Ciclo: " + _datosM[index].ciclo.toString(),
                    style: TextStyle(fontSize: 18)),
                Divider(),
              ],
            ),
          );
        },
        itemCount: _datosM.length,
      ),
    );
  }
}
