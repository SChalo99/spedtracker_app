import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spedtracker_app/components/movements/movement_dragable.dart';
import 'package:spedtracker_app/models/gasto_model.dart';
import 'package:spedtracker_app/models/ingreso_model.dart';
import 'package:spedtracker_app/models/movement_model.dart';

void main() {
  group('Pruebas MovementDragable', () {
    testWidgets(
        'DragableMovement debe mostrar los ingresos asignados correctamente',
        (WidgetTester tester) async {
      //Se crean los atributos
      List<MovementModel> ingresos = [
        IngresoModel('1', 1200.00, 'nada', DateTime.now(), DateTime.now())
      ];
      // Crea un widget de prueba
      var widget = MaterialApp(
        home: DragableMovement(
          movements: ingresos,
          edit: () {},
          delete: () {},
          goToCallback: () {},
        ),
      );

      // Construye el widge
      await tester.pumpWidget(widget);

      // Verifica que el ingreso sea marcado como positivo y se muestre
      expect(find.text("1200.0"), findsOneWidget);
    });
    testWidgets(
        'DragableMovement debe mostrar los gastos asignados correctamente',
        (WidgetTester tester) async {
      //Se crean los atributos
      List<MovementModel> gastos = [
        GastoModel(
            1, 0, '1', 1200, 'descripcion', DateTime.now(), DateTime.now())
      ];

      // Crea un widget de prueba
      var widget = MaterialApp(
        home: DragableMovement(
          movements: gastos,
          edit: () {},
          delete: () {},
          goToCallback: () {},
        ),
      );

      // Construye el widge
      await tester.pumpWidget(widget);

      // Verifica que el ingreso sea marcado como positivo y se muestre
      expect(find.text("-1200.0"), findsOneWidget);
    });
    testWidgets(
        'DragableMovement debe mostrar los colores de los montos rojo si es gasto o verde si es ingreso correctamente',
        (WidgetTester tester) async {
      //Se crean los atributos
      List<MovementModel> gastos = [
        GastoModel(
            1, 0, '1', 1200, 'descripcion', DateTime.now(), DateTime.now())
      ];

      // Crea un widget de prueba
      var widget = MaterialApp(
        home: DragableMovement(
          movements: gastos,
          edit: () {},
          delete: () {},
          goToCallback: () {},
        ),
      );

      // Construye el widge
      await tester.pumpWidget(widget);

      // Verifica que el ingreso sea marcado como positivo y se muestre
      expect((tester.firstWidget(find.text('-1200.0')) as Text).style!.color,
          Colors.red);
    });
    testWidgets(
        'DragableMovement debe mostrar la descripcion de los movimientos correctamente',
        (WidgetTester tester) async {
      //Se crean los atributos
      List<MovementModel> gastos = [
        GastoModel(
            1, 0, '1', 1200, 'descripcion', DateTime.now(), DateTime.now())
      ];

      // Crea un widget de prueba
      var widget = MaterialApp(
        home: DragableMovement(
          movements: gastos,
          edit: () {},
          delete: () {},
          goToCallback: () {},
        ),
      );

      // Construye el widge
      await tester.pumpWidget(widget);

      // Verifica que el ingreso sea marcado como positivo y se muestre
      expect(find.text("descripcion"), findsOneWidget);
    });
  });
}
