import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './styles.dart';
import 'grupos_screen.dart';

class SedesScreen extends StatefulWidget {
  final String codInst;

  SedesScreen(this.codInst);

  @override
  _SedesScreenState createState() => _SedesScreenState();
}

class _SedesScreenState extends State<SedesScreen> {
  List sedes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSedes();
  }

  Future<void> fetchSedes() async {
    final dio = Dio();
    final response = await dio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'sedes',
        'CodInst': widget.codInst
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      setState(() {
        sedes = data['data'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load sedes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sedes'),
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
                    itemCount: sedes.length,
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
                              sedes[index]['nombre'],
                              style: AppStyles.listItemTextStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GruposScreen(
                                  sedes[index]['dane'],
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
