import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica/main.dart';

void main() {
  testWidgets('Municipios screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Municipios'), findsOneWidget);

    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Instituciones screen test', (WidgetTester tester) async {
    // Navigate to InstitucionesScreen.
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('CHAPARRAL'));
    await tester.pumpAndSettle();

    expect(find.text('Instituciones'), findsOneWidget);

    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Sedes screen test', (WidgetTester tester) async {
    // Navigate to SedesScreen.
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('CHAPARRAL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('I.E. SIMON BOLIVAR'));
    await tester.pumpAndSettle();

    expect(find.text('Sedes'), findsOneWidget);

    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Grupos screen test', (WidgetTester tester) async {
    // Navigate to GruposScreen.
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('CHAPARRAL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('I.E. SIMON BOLIVAR'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SEDE PRINCIPAL'));
    await tester.pumpAndSettle();

    expect(find.text('Grupos'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });
}
