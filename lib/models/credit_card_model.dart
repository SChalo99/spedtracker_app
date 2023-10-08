import 'package:spedtracker_app/models/card_model.dart';

class CreditCard extends CardModel {
  DateTime dueDate;
  DateTime lastPayDay;
  double interest;

  CreditCard(
    String cardId,
    String cardNum,
    String currency,
    String type,
    String cardHolder,
    String expMonth,
    String expYear,
    String service,
    this.dueDate,
    this.lastPayDay,
    this.interest,
  ) {
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
