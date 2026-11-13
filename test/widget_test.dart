import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:divisor_cuenta/pantallas/pantalla_cuenta.dart';

void main() {
  testWidgets(
    'La aplicación muestra el divisor de cuenta',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PantallaCuenta(),
        ),
      );

      expect(find.text('Divisor de cuenta'), findsOneWidget);
      expect(find.text('Cantidad de personas'), findsOneWidget);
      expect(find.text('Resultados'), findsOneWidget);
    },
  );

  testWidgets(
    'Permite aumentar la cantidad de personas',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PantallaCuenta(),
        ),
      );

      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    },
  );
}
