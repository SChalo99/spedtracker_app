import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spedtracker_app/screens/login/login_screen.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';

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
  group('Pruebas Login', () {
    testWidgets('Verificar que login está renderizado',
        (WidgetTester tester) async {
      const widget = MaterialApp(
        home: LoginScreen(),
      );

      await tester.pumpWidget(widget);
      // Verificar LoginScreen widget está cargado: Sale error debido a Firebase Widget no está inicializado
      expect(find.byType(LoginScreen), findsOneWidget);
    });
    testWidgets('Login', (WidgetTester tester) async {
      const widget = MaterialApp(
        home: LoginScreen(),
      );

      await tester.pumpWidget(widget);
      final LoginScreenState state = tester.state(find.byType(LoginScreen));
      state.login('20163126@aloe.ulima.edu.pe', '123456');
      expect(state.currentUser.currentUser.nombre, '');
    });
  });
}
