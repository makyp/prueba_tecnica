import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './styles.dart';
import 'sedes_screen.dart';

class InstitucionesScreen extends StatefulWidget {
  final String codMun;

  InstitucionesScreen(this.codMun);

  @override
  _InstitucionesScreenState createState() => _InstitucionesScreenState();
}

class _InstitucionesScreenState extends State<InstitucionesScreen> {
  List instituciones = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInstituciones();
  }

  Future<void> fetchInstituciones() async {
    final dio = Dio();
    final response = await dio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'instituciones',
        'CodMun': widget.codMun
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      setState(() {
        instituciones = data['data'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load instituciones');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Instituciones'),
      body: Column(
        children: [
          isLoading
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: instituciones.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        elevation: 3,
                        child: ListTile(
                          tileColor: Colors.white,
                          hoverColor: Colors.blue.withOpacity(0.2),
                          title: Center(
                            child: Text(
                              instituciones[index]['nombre'],
                              style: AppStyles.listItemTextStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SedesScreen(
                                  instituciones[index]['dane'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Creado por Maira Quiroga',
              style: AppStyles.footerTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
