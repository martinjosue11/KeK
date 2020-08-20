import 'package:flutter/material.dart';
import 'package:materias_dos/src/pages/ingresar_codigo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => IngresarCodigoPage(),
      },
    );
  }
}
