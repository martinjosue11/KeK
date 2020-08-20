import 'package:materias_dos/src/pages/datos_materias_page.dart';
import 'package:materias_dos/src/providers/db_providers.dart';
import 'package:materias_dos/src/providers/alumnos_api_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);
  final String urlCodes;
  HomePage(this.urlCodes);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;
  int thing = 0;
  @override
  Widget build(BuildContext context) {
    if (thing == 0) {
      _deleteData();
      thing = 1;
      _loadFromApi();
    }
    final String _urlcode = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Materias'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.settings_input_antenna),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildAlumnosListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = AlumnosApiProvider(widget.urlCodes);
    await apiProvider.getAllAlumnos();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllAlumnos();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All alumnos deleted');
  }

  _buildAlumnosListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllAlumnos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20.0),
                ),
                title: Text(
                    "Profesor: ${snapshot.data[index].nombre_profesor}\nMateria: ${snapshot.data[index].nombre_materia} "),
                subtitle: Text('CRN MATERIA: ${snapshot.data[index].crn}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DatosMateriasPage(
                          snapshot.data[index].crn.toString())));
                },
              );
            },
          );
        }
      },
    );
  }
}
