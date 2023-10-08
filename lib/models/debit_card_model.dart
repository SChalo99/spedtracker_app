import 'package:spedtracker_app/models/card_model.dart';

class DebitCard extends CardModel {
  String accountNum;

  DebitCard(
      String cardId,
      String cardNum,
      String currency,
      String type,
      String cardHolder,
      String expMonth,
      String expYear,
      String service,
      this.accountNum) {
    super.cardId = cardId;
    super.cardNum = cardNum;
    super.currency = currency;
    super.type = type;
    super.cardHolder = cardHolder;
    super.expMonth = expMonth;
    super.expYear = expYear;
    super.service = service;
  }
}
