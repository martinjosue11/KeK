import 'package:flutter/material.dart';
import '../providers/alumnos_api_provider.dart';
import 'home_page.dart';

class IngresarCodigoPage extends StatefulWidget {
  @override
  _IngresarCodigoPageState createState() => _IngresarCodigoPageState();
}

class _IngresarCodigoPageState extends State<IngresarCodigoPage> {
  TextEditingController codigoController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar Codigo SIIAU'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: codigoController,
              decoration: const InputDecoration(hintText: 'Ingresa Tu Codigo'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingresa tu codigo';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    AlumnosApiProvider(codigoController.text);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(codigoController.text)));
                  }
                },
                child: Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
