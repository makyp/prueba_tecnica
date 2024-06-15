import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educational Institutions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MunicipioScreen(),
    );
  }
}

class MunicipioScreen extends StatefulWidget {
  @override
  _MunicipioScreenState createState() => _MunicipioScreenState();
}

class _MunicipioScreenState extends State<MunicipioScreen> {
  List municipios = [];

  @override
  void initState() {
    super.initState();
    fetchMunicipios();
  }

  Future<void> fetchMunicipios() async {
    final response = await http.post(
      Uri.parse('https://www.php.engenius.com.co/DatabaseIE.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'municipios'
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        municipios = data['data'];
      });
    } else {
      throw Exception('Failed to load municipios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Municipios'),
      ),
      body: ListView.builder(
        itemCount: municipios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(municipios[index]['nombre']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InstitucionesScreen(municipios[index]['dane']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class InstitucionesScreen extends StatefulWidget {
  final String codMun;

  InstitucionesScreen(this.codMun);

  @override
  _InstitucionesScreenState createState() => _InstitucionesScreenState();
}

class _InstitucionesScreenState extends State<InstitucionesScreen> {
  List instituciones = [];

  @override
  void initState() {
    super.initState();
    fetchInstituciones();
  }

  Future<void> fetchInstituciones() async {
    final response = await http.post(
      Uri.parse('https://www.php.engenius.com.co/DatabaseIE.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'instituciones',
        'CodMun': widget.codMun
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        instituciones = data['data'];
      });
    } else {
      throw Exception('Failed to load instituciones');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instituciones'),
      ),
      body: ListView.builder(
        itemCount: instituciones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(instituciones[index]['nombre']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SedesScreen(instituciones[index]['dane']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SedesScreen extends StatefulWidget {
  final String codInst;

  SedesScreen(this.codInst);

  @override
  _SedesScreenState createState() => _SedesScreenState();
}

class _SedesScreenState extends State<SedesScreen> {
  List sedes = [];

  @override
  void initState() {
    super.initState();
    fetchSedes();
  }

  Future<void> fetchSedes() async {
    final response = await http.post(
      Uri.parse('https://www.php.engenius.com.co/DatabaseIE.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'sedes',
        'CodInst': widget.codInst
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        sedes = data['data'];
      });
    } else {
      throw Exception('Failed to load sedes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sedes'),
      ),
      body: ListView.builder(
        itemCount: sedes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sedes[index]['nombre']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GruposScreen(sedes[index]['dane']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GruposScreen extends StatefulWidget {
  final String codSede;

  GruposScreen(this.codSede);

  @override
  _GruposScreenState createState() => _GruposScreenState();
}

class _GruposScreenState extends State<GruposScreen> {
  List grupos = [];

  @override
  void initState() {
    super.initState();
    fetchGrupos();
  }

  Future<void> fetchGrupos() async {
    final response = await http.post(
      Uri.parse('https://www.php.engenius.com.co/DatabaseIE.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'grupos',
        'CodSede': widget.codSede
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        grupos = data['data'];
      });
    } else {
      throw Exception('Failed to load grupos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grupos'),
      ),
      body: ListView.builder(
        itemCount: grupos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(grupos[index]['nombre']),
          );
        },
      ),
    );
  }
}
