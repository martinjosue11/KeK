class MateriaDatos {
  var aula;
  String dia;
  var hora_inicio;
  var hora_fin;
  var crn;
  var ciclo;
  MateriaDatos(this.aula, this.dia, this.hora_inicio, this.hora_fin, this.crn,
      this.ciclo);

  MateriaDatos.fromJson(Map<String, dynamic> json) {
    aula = json['aula'];
    dia = json['dia'];
    hora_inicio = json['hora_inicio'];
    hora_fin = json['hora_fin'];
    crn = json['crn'];
    ciclo = json['ciclo'];
  }
}
