import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spedtracker_app/components/selector_chip/atom.dart';

void main() {
  group('Pruebas FilterSelector', () {
    testWidgets('MonthFilterSelector widget test', (WidgetTester tester) async {
      Set<String> initialFilters = {'Ene', 'Feb'};

      Function mockToggleFilterCallback = (String month, bool selected) {};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MonthFilterSelector(
              toggleFilterCallback: mockToggleFilterCallback,
              filters: initialFilters,
            ),
          ),
        ),
      );

      // MonthFilterSelector  rendered
      expect(find.byType(MonthFilterSelector), findsOneWidget);
    });
  });
}
