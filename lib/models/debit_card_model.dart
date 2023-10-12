import 'package:spedtracker_app/models/card_model.dart';

class DebitCard extends CardModel {
  String accountNum;
  double ingresoMinimo;

  DebitCard(
    String cardId,
    String cardNum,
    String currency,
    String type,
    String cardHolder,
    String expMonth,
    String expYear,
    String operadora,
    this.accountNum,
    this.ingresoMinimo,
  ) {
    super.idTarjeta = cardId;
    super.numeroTarjeta = cardNum;
    super.moneda = currency;
    super.type = type;
    super.cardHolder = cardHolder;
    super.expMonth = expMonth;
    super.expYear = expYear;
    super.operadoraFinanciera = operadora;
  }
}
