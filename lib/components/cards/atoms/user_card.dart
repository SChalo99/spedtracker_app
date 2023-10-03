import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class UserCard extends StatelessWidget {
  final String cardId;
  final String cardNum;
  final String type;
  final String cardHolder;
  final String expMonth;
  final String expYear;
  final String service;
  final Function goTo;

  const UserCard(
      {super.key,
      required this.cardId,
      required this.cardNum,
      required this.type,
      required this.cardHolder,
      required this.expMonth,
      required this.expYear,
      required this.service,
      required this.goTo});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      onTap: () {
        goTo(cardId);
      },
      subtitle: CreditCardWidget(
        cardNumber: cardNum,
        expiryDate: "$expMonth/$expYear",
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
