import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spedtracker_app/components/cards/atoms/user_card.dart';
import 'package:spedtracker_app/components/cards/molecules/card_dragable.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';

void main() {
  group('Pruebas CardDragable', () {
    testWidgets('CardDragable debe cargar correctamente',
        (WidgetTester tester) async {
      //Se crean los atributos
      List<CardModel> mockCards = [
        DebitCard('1', '9988777', 'soles', DateTime.now(), 'VISA', '89128918',
            120.00),
      ];
      // Mock functions for edit, delete, and goToCallback
      Function mockEdit = (CardModel card) {};
      Function mockDelete = (CardModel card) {};
      Function mockGoToCallback = (CardModel card) {};

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DragableCard(
              cards: mockCards,
              edit: mockEdit,
              delete: mockDelete,
              goToCallback: mockGoToCallback,
            ),
          ),
        ),
      );
      // Verify that the DragableCard widget is rendered
      expect(find.byType(DragableCard), findsOneWidget);
    });

    testWidgets('CardDragable debe cargar Slidable correctamente',
        (WidgetTester tester) async {
      //Se crean los atributos
      List<CardModel> mockCards = [
        DebitCard('1', '9988777', 'soles', DateTime.now(), 'VISA', '89128918',
            120.00),
      ];
      // Mock functions for edit, delete, and goToCallback
      Function mockEdit = (CardModel card) {};
      Function mockDelete = (CardModel card) {};
      Function mockGoToCallback = (CardModel card) {};

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DragableCard(
              cards: mockCards,
              edit: mockEdit,
              delete: mockDelete,
              goToCallback: mockGoToCallback,
            ),
          ),
        ),
      );
      // Verify that the Slidable widget is rendered
      expect(find.byType(Slidable), findsOneWidget);
    });

    testWidgets('CardDragable debe cargar UserCard correctamente',
        (WidgetTester tester) async {
      List<CardModel> mockCards = [
        DebitCard('1', '9988777', 'soles', DateTime.now(), 'VISA', '89128918',
            120.00),
      ];

      // Mock functions for edit, delete, and goToCallback
      Function mockEdit = (CardModel card) {};
      Function mockDelete = (CardModel card) {};
      Function mockGoToCallback = (CardModel card) {};

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DragableCard(
              cards: mockCards,
              edit: mockEdit,
              delete: mockDelete,
              goToCallback: mockGoToCallback,
            ),
          ),
        ),
      );

      expect(find.byType(UserCard), findsOneWidget);
    });
    testWidgets('CardDragable debe cargar ListView correctamente',
        (WidgetTester tester) async {
      List<CardModel> mockCards = [
        DebitCard('1', '9988777', 'soles', DateTime.now(), 'VISA', '89128918',
            120.00),
      ];

      // Mock functions for edit, delete, and goToCallback
      Function mockEdit = (CardModel card) {};
      Function mockDelete = (CardModel card) {};
      Function mockGoToCallback = (CardModel card) {};

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DragableCard(
              cards: mockCards,
              edit: mockEdit,
              delete: mockDelete,
              goToCallback: mockGoToCallback,
            ),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
