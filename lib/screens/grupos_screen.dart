import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './styles.dart';

class GruposScreen extends StatefulWidget {
  final String codSede;

  GruposScreen(this.codSede);

  @override
  _GruposScreenState createState() => _GruposScreenState();
}

class _GruposScreenState extends State<GruposScreen> {
  List grupos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGrupos();
  }

  Future<void> fetchGrupos() async {
    final dio = Dio();
    final response = await dio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'grupos',
        'CodSede': widget.codSede
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      setState(() {
        grupos = data['data'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load grupos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Grupos'),
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
                    itemCount: grupos.length,
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
                              grupos[index]['nombre'],
                              style: AppStyles.listItemTextStyle,
                            ),
                          ),
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
