import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:spedtracker_app/screens/login/signup_screen.dart';

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
  group('Pruebas Signup', () {
    testWidgets('Verificar que signup está renderizado',
        (WidgetTester tester) async {
      const widget = MaterialApp(
        home: SignUpScreen(),
      );

      await tester.pumpWidget(widget);
      // Verificar LoginScreen widget está cargado: Sale error debido a Firebase Widget no está inicializado
      expect(find.byType(SignUpScreen), findsOneWidget);
    });
    testWidgets('Signup', (WidgetTester tester) async {
      const widget = MaterialApp(
        home: SignUpScreen(),
      );

      await tester.pumpWidget(widget);
      final SignUpScreenState state = tester.state(find.byType(SignUpScreen));
      state.signup('20163126@aloe.ulima.edu.pe', '123456');
      expect(state.currentUser.currentUser.nombre, '');
    });
  });
}
