import 'dart:convert';

List<Alumnos> alumnoFromJson(String str) =>
    List<Alumnos>.from(json.decode(str).map((x) => Alumnos.fromJson(x)));

String alumnoToJson(List<Alumnos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alumnos {
  var id_registro;
  var codigo_profesor;
  String nombre_profesor;
  String nombre_materia;
  var crn;
  String ciclo;
  String evaluo;

  Alumnos(
      {this.id_registro,
      this.codigo_profesor,
      this.nombre_profesor,
      this.nombre_materia,
      this.crn,
      this.ciclo,
      this.evaluo});

  factory Alumnos.fromJson(Map<String, dynamic> json) => Alumnos(
        id_registro: json["id_registro"],
        codigo_profesor: json["codigo_profesor"],
        nombre_profesor: json["nombre_profesor"],
        nombre_materia: json["nombre_materia"],
        crn: json["crn"],
        ciclo: json["ciclo"],
        evaluo: json["evaluo"],
      );

  Map<String, dynamic> toJson() => {
        "id_registro": id_registro,
        "codigo_profesor": codigo_profesor,
        "nombre_profesor": nombre_profesor,
        "nombre_materia": nombre_materia,
        "crn": crn,
        "ciclo": ciclo,
        "evaluo": evaluo,
      };
}
