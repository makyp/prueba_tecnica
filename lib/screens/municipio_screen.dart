import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './styles.dart';
import 'instituciones_screen.dart';

class MunicipioScreen extends StatefulWidget {
  @override
  _MunicipioScreenState createState() => _MunicipioScreenState();
}

class _MunicipioScreenState extends State<MunicipioScreen> {
  List municipios = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMunicipios();
  }

  Future<void> fetchMunicipios() async {
    final dio = Dio();
    final response = await dio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'municipios'
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      setState(() {
        municipios = data['data'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load municipios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Municipios'),
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
                    itemCount: municipios.length,
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
                              municipios[index]['nombre'],
                              style: AppStyles.listItemTextStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InstitucionesScreen(
                                  municipios[index]['dane'],
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
