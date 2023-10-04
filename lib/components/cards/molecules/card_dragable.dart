import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/cards/atoms/user_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spedtracker_app/models/card_model.dart';

class DragableCard extends StatelessWidget {
  final List<CardModel> cards;
  final Function edit;
  final Function delete;
  final Function goToCallback;

  const DragableCard({
    super.key,
    required this.cards,
    required this.edit,
    required this.delete,
    required this.goToCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          CardModel card = cards[index];
          return Slidable(
            startActionPane: ActionPane(
                extentRatio: 0.6,
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    onPressed: (context) {
                      edit(card);
                    },
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  ),
                  SlidableAction(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    onPressed: (context) {
                      delete(card.cardId);
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Eliminar',
                  ),
                ]),
            child: UserCard(
              cardId: card.cardId,
              cardNum: card.cardNum,
              type: card.type,
              cardHolder: card.cardHolder,
              expMonth: card.expMonth,
              expYear: card.expYear,
              service: card.service,
              goTo: goToCallback,
            ),
          );
        });
  }
}
