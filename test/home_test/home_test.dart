import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:spedtracker_app/screens/home_screen.dart';
import 'package:spedtracker_app/screens/login/login_screen.dart';
import 'package:spedtracker_app/screens/movementManager/card_selector.dart';

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

class MockPageFirebaseAuth extends Mock implements PageController {}

void main() {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('Pruebas Home', () {
    testWidgets('Creación HomeScreen widget', (WidgetTester tester) async {
      await tester.pumpWidget(
          const MaterialApp(home: HomeScreen(userToken: 'mockToken')));

      // Verificar que el HomeScreen widget está renderizado
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Navigate to CardScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
          const MaterialApp(home: HomeScreen(userToken: 'mockToken')));

      // Tap el "Gestionar Tarjetas" button
      await tester.tap(find.text("Gestionar Tarjetas"));
      await tester.pumpAndSettle(const Duration(seconds: 60));

      // Verificar CardScreen widget está cargado: Sale error debido a que carga data por http
      expect(find.byType(CardScreen), findsOneWidget);
    });

    testWidgets('Navigate to MovementCardSelectorScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          const MaterialApp(home: HomeScreen(userToken: 'mockToken')));

      // Tap el "Gestionar Movimientos" button
      await tester.tap(find.text("Gestionar Movimientos"));
      await tester.pumpAndSettle();

      // Verificar MovementCardSelectorScreen widget está cargado: Sale error debido a que carga data por http
      expect(find.byType(MovementCardSelectorScreen), findsOneWidget);
    });

    testWidgets('Logout and Navigate to LoginScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(userToken: 'mockToken'),
        ),
      );

      // Tap the "Cerrar Sesión" button
      await tester.tap(find.text("Cerrar Sesión"));
      //await tester.pumpAndSettle();
      await tester.pumpAndSettle(const Duration(seconds: 3));
      // Error debido a que Firebase no esta inicializado (No sesión activa)
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
