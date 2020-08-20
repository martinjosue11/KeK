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
          centerTitle: true,
          title: Text('Sistema Consultador Materias'),
        ),
        resizeToAvoidBottomPadding: true,
        //
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: [
                Text(
                  'Consultar Materias y Horarios',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[300],
                    fontSize: 18.0,
                  ),
                ),
                Divider(
                  height: 20.0,
                ),
                TextFormField(
                  maxLength: 9,
                  autofocus: true,
                  controller: codigoController,
                  decoration: const InputDecoration(
                      hintText: 'Ingresa Tu Codigo',
                      labelText: 'Codigo*',
                      icon: Icon(Icons.bubble_chart)),
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
                    color: Colors.teal[400],
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        AlumnosApiProvider(codigoController.text);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                HomePage(codigoController.text)));
                      }
                    },
                    child: Text('Continuar'),
                  ),
                ),
                Divider(
                  height: 50.0,
                ),
                GirarAnimacion(
                  icon: Icons.track_changes,
                )
              ],
            ),
          ),
        ));
  }
}

class GirarAnimacion extends StatefulWidget {
  final IconData icon;
  final Duration duration;

  const GirarAnimacion({
    Key key,
    @required this.icon,
    this.duration = const Duration(milliseconds: 1800),
  }) : super(key: key);

  @override
  _GirarAnimacionState createState() => _GirarAnimacionState();
}

class _GirarAnimacionState extends State<GirarAnimacion>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Widget _child;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..repeat();
    _child = Icon(
      widget.icon,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: _child,
    );
  }
}
