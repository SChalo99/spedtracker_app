import 'package:spedtracker_app/models/card_model.dart';

class DebitCard extends CardModel {
  String accountNum;
  double ingresoMinimo;

  DebitCard(
    String cardId,
    String cardNum,
    String currency,
    DateTime expDate,
    String operadora,
    this.accountNum,
    this.ingresoMinimo, {
    String cardHolder = '',
  }) {
    super.idTarjeta = cardId;
    super.numeroTarjeta = cardNum;
    super.moneda = currency;
    super.expDate = expDate;
    super.operadoraFinanciera = operadora;
    super.cardHolder = cardHolder;
  }
}
