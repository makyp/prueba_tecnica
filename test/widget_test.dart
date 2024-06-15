import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:prueba_tecnica/main.dart';

import 'dio_mock.dart';

void main() {
  final mockDio = MockDio();

  setUp(() {
    when(mockDio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'municipios'
      },
    )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'login': 'Success',
            'option': 'municipios',
            'data': [
              {'nombre': 'CHAPARRAL', 'dane': '73168'},
              {'nombre': 'ESPINAL', 'dane': '73268'}
            ],
          },
          statusCode: 200,
        ));

    when(mockDio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'instituciones',
        'CodMun': '73168'
      },
    )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'login': 'Success',
            'option': 'instituciones',
            'data': [
              {'nombre': 'I.E. SIMON BOLIVAR', 'dane': '273168000908'}
            ],
          },
          statusCode: 200,
        ));

    when(mockDio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'sedes',
        'CodInst': '273168000908'
      },
    )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'login': 'Success',
            'option': 'sedes',
            'data': [
              {'nombre': 'SEDE PRINCIPAL', 'dane': '273168002111'}
            ],
          },
          statusCode: 200,
        ));

    when(mockDio.post(
      'https://www.php.engenius.com.co/DatabaseIE.php',
      data: {
        'User': 'etraining',
        'Password': 'explorandoando2020%',
        'option': 'grupos',
        'CodSede': '273168002111'
      },
    )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'login': 'Success',
            'option': 'grupos',
            'data': [
              {
                'id': '10065',
                'nombre': 'INNOVADORES DEL PLANETA',
                'numGrupo': '1'
              }
            ],
          },
          statusCode: 200,
        ));
  });

  testWidgets('Municipios screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Municipios'), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('CHAPARRAL'), findsOneWidget);
    expect(find.text('ESPINAL'), findsOneWidget);
  });

  testWidgets('Instituciones screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('CHAPARRAL'));
    await tester.pumpAndSettle();

    expect(find.text('Instituciones'), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.text('I.E. SIMON BOLIVAR'), findsOneWidget);
  });
  testWidgets('Sedes screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('CHAPARRAL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('I.E. SIMON BOLIVAR'));
    await tester.pumpAndSettle();

    expect(find.text('Sedes'), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.text('SEDE PRINCIPAL'), findsOneWidget);
  });

  testWidgets('Grupos screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('CHAPARRAL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('I.E. SIMON BOLIVAR'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SEDE PRINCIPAL'));
    await tester.pumpAndSettle();

    expect(find.text('Grupos'), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.text('INNOVADORES DEL PLANETA'), findsOneWidget);
  });
}
