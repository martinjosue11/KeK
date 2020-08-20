import 'dart:io';
import 'package:materias_dos/src/models/alumno_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'alumnos_materias.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE Alumnos(
          id_registro INTEGER PRIMARY KEY,
          codigo_profesor INTEGER,
          nombre_profesor TEXT,
          nombre_materia TEXT,
          crn INTEGER,
          ciclo VARCHAR(45),
          evaluo TEXT
          )''');
    });
  }

  createAlumnos(Alumnos newAlumnos) async {
    await deleteAllAlumnos();
    final db = await database;
    final res = await db.insert('Alumnos', newAlumnos.toJson());

    return res;
  }

  Future<int> deleteAllAlumnos() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Alumnos');

    return res;
  }

  Future<List<Alumnos>> getAllAlumnos() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Alumnos");

    List<Alumnos> list =
        res.isNotEmpty ? res.map((c) => Alumnos.fromJson(c)).toList() : [];

    return list;
  }
}
