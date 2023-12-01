import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/screens/overall/overal_month.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('Pruebas resumen', () {
    testWidgets('resumen está renderizado', (WidgetTester tester) async {
      var widget = MaterialApp(
        home: OverallMonthScreen(
          userToken: 'token',
          card: DebitCard('1', '9988777', 'soles', DateTime.now(), 'VISA',
              '89128918', 120.00),
        ),
      );

      await tester.pumpWidget(widget);
      //Error por carga de datos del servidor.
      expect(find.byType(OverallMonthScreen), findsOneWidget);
    });
  });
}
