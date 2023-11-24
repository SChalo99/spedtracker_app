import 'package:flutter/material.dart';
import 'package:spedtracker_app/components/cards/atoms/user_card.dart';
import 'package:spedtracker_app/models/card_model.dart';

class ListCard extends StatelessWidget {
  final List<CardModel> cards;
  final Function goToCallback;

  const ListCard({
    super.key,
    required this.cards,
    required this.goToCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          CardModel card = cards[index];
          return UserCard(
            cardId: card.idTarjeta,
            cardNum: card.numeroTarjeta,
            cardHolder: card.cardHolder,
            expDate:
                "${card.expDate!.toString().split("-")[1]}/${card.expDate!.year.toString().split("0")[1]}",
            service: card.operadoraFinanciera,
            goTo: goToCallback,
          );
        });
  }
}
