import 'package:http/http.dart';
import 'package:materias_dos/src/models/alumno_model.dart';
import 'package:materias_dos/src/providers/db_providers.dart';
//import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlumnosApiProvider {
  List data;

  Future<List<Alumnos>> getAllAlumnos() async {
    var url = "http://148.202.89.11/encuesta/api/materias.php?codigo=219737144";
    Response response = await http.get(url);

    var alumnos = List<Alumnos>();

    if (response.statusCode == 200) {
      var materias = json.decode(response.body);
      for (var materia in materias) {
        alumnos.add(Alumnos.fromJson(materia));
      }
    }

    return (alumnos).map((alumnos) {
      print('Inserting $alumnos');
      DBProvider.db.createAlumnos(alumnos);
    }).toList();
  }
}

// class AlumnosApiProvider {
//   Future<List<Alumnos>> getAllAlumnos() async {
//     var url = "http://148.202.89.11/encuesta/api/materias.php?codigo=219737144";
//     Response response = await Dio().get(url);

//     return (response.data as List).map((alumnos) {
//       print('Inserting $alumnos');
//       DBProvider.db.createAlumnos(Alumnos.fromJson(alumnos));
//     }).toList();
//   }
