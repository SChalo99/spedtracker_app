import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:spedtracker_app/models/card_model.dart';

class UserCard extends StatelessWidget {
  final String cardId;
  final String cardNum;
  final String cardHolder;
  final String expDate;
  final String service;
  final Function goTo;
  final CardModel card;

  const UserCard(
      {super.key,
      required this.cardId,
      required this.cardNum,
      required this.cardHolder,
      required this.expDate,
      required this.service,
      required this.goTo,
      required this.card});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        goTo(card);
      },
      subtitle: CreditCardWidget(
        cardNumber: cardNum,
        expiryDate: expDate,
        cardHolderName: cardHolder,
        isHolderNameVisible: true,
        cvvCode: "XXX",
        showBackView: false,
        isChipVisible: true,
        isSwipeGestureEnabled: false,
        onCreditCardWidgetChange:
            (CreditCardBrand) {}, //true when you want to show cvv(back) view
      ),
    );
  }
}