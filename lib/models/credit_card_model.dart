import 'package:spedtracker_app/models/card_model.dart';

class CreditCard extends CardModel {
  DateTime fechaFacturacion;
  DateTime ultimoDiaPago;
  double tasaInteres;
  double lineaCredito;

  CreditCard(
    String cardId,
    String cardNum,
    String currency,
    String type,
    String cardHolder,
    String expMonth,
    String expYear,
    String operadora,
    this.fechaFacturacion,
    this.ultimoDiaPago,
    this.tasaInteres,
    this.lineaCredito,
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
