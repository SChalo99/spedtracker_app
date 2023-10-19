import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:spedtracker_app/components/alerts/alert_config.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/models/user_singleton.dart';
//import 'package:spedtracker_app/screens/cardManager/add_card_screen.dart'; NO BORRAR ESTE COMENTARIO
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:spedtracker_app/services/card_service.dart';
import 'package:spedtracker_app/services/notification_service.dart';


class EditCardScreen extends StatefulWidget {
  final String userToken;
  final CardModel card;
  const EditCardScreen(
      {super.key, required this.userToken, required this.card});

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}


class _EditCardScreenState extends State<EditCardScreen> {
  
  CardModel? card;
  OutlineInputBorder border = const OutlineInputBorder();
  final _formKey = GlobalKey<FormState>();
  final AlertConfig config = AlertConfig.instance;
  UserSingleton user = UserSingleton.instance;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardService = '';
  String cardType = '';
  late CardType brand;
  List<String> types = ['CREDITO', 'DEBITO'];
  List<String> moneda = ['SOLES', 'DOLARES'];
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _payDayController = TextEditingController();
  final TextEditingController _dueDayController = TextEditingController();
  final TextEditingController _interesController = TextEditingController();
  final TextEditingController _lineController = TextEditingController();
  String currency = '';

  void onCreditCardModel(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
    });
  }

  void onCreditCardWidgetChange(CreditCardBrand creditCardBrand) {
    if (context.mounted) {
      cardService = creditCardBrand.brandName!.name.toUpperCase();
      _brandController.value = TextEditingController.fromValue(
        TextEditingValue(text: cardService),
      ).value;
    }
  }
  
  /*5
  Future<void> editCard(CardModel card) async {
    List<String> date = expiryDate.split("/");
    DateTime expDate = DateTime.parse("20${date[1]}-${date[0]}-01");
    setState(() {
      card.expDate = expDate;
      card.operadoraFinanciera = cardService;
      card.numeroTarjeta = cardNumber;
      card.moneda = currency;
    });
    DateTime expDateNotification = expDate.subtract(const Duration(days: 10));

    debugPrint(expDateNotification.toString());
    int cardNumLenght = cardNumber.length;
    if (card is CreditCard) {
      setState(() {
        card.fechaFacturacion = DateTime.parse(_dueDayController.text);
        card.lineaCredito = double.parse(_lineController.text);
        card.ultimoDiaPago = DateTime.parse(_payDayController.text);
        card.tasaInteres = double.parse(_interesController.text);
      });
    } else if (card is DebitCard) {
      setState(() {
        card.ingresoMinimo = double.parse(_montoController.text);
        card.accountNum = _accountController.text;
      });
    }
    await CardService().editCard(widget.userToken, card);
    createNotifications(cardNumLenght, expDateNotification);
  }

  void createNotifications(int cardNumLenght, DateTime expDateNotification) {
    NotificationService().addScheduleNotification(
        'Vencimiento Tarjeta',
        'Su Tarjeta que termina en *${cardNumber[cardNumLenght - 4]}${cardNumber[cardNumLenght - 3]}${cardNumber[cardNumLenght - 2]}${cardNumber[cardNumLenght - 1]} está por vencer en 10 días.',
        expDateNotification);

    if (cardType == 'CREDITO') {
      NotificationService().addScheduleNotification(
          'Pago Tarjeta',
          'El pago de su Tarjeta que termina en *${cardNumber[cardNumLenght - 4]}${cardNumber[cardNumLenght - 3]}${cardNumber[cardNumLenght - 2]}${cardNumber[cardNumLenght - 1]} está por vence en 10 días.',
          DateTime.parse(_payDayController.text)
              .subtract(const Duration(days: 10)));
      NotificationService().addScheduleNotification(
          'Ciclo de Crédito',
          'Su Tarjeta que termina en *${cardNumber[cardNumLenght - 4]}${cardNumber[cardNumLenght - 3]}${cardNumber[cardNumLenght - 2]}${cardNumber[cardNumLenght - 1]} está en su último día de su ciclo de facturación.',
          DateTime.parse(_dueDayController.text));
    }
    debugPrint("Notifications created");
  }
/*------NO BORRAR-------------------------------------------------------------->
  void addExtensionCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => AddCardScreen(
              userToken: widget.userToken,
              isExtension: true,
            )),
      ),
    );
  }
  ------NO BORRAR-------------------------------------------------------------->*/

  void loadData(CardModel card) {
    setState(() {
      cardNumber = card.numeroTarjeta;
      expiryDate =
          "${card.expDate!.toString().split("-")[1]}/${card.expDate!.year.toString().split("0")[1]}";
      cardHolderName = card.cardHolder;
      cardType = card is CreditCard ? types[0] : types[1];
      cardService = card.operadoraFinanciera;
      currency = card.moneda;
    });

    if (card is CreditCard) {
      setState(() {
        _dueDayController.text = card.fechaFacturacion.toString();
        _lineController.text = card.lineaCredito.toString();
        _payDayController.text = card.ultimoDiaPago.toString();
        _interesController.text = card.tasaInteres.toString();
      });
    } else if (card is DebitCard) {
      setState(() {
        _montoController.text = card.ingresoMinimo.toString();
        _accountController.text = card.accountNum;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    card = widget.card;
    loadData(card!);
  }
5*/
/*4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: SchedulerBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.light
                  ? const ColorScheme.light().background
                  : const Color.fromRGBO(116, 107, 85, 1)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: "XXX",
                showBackView: false,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (creditCardBrand) {
                  onCreditCardWidgetChange(creditCardBrand);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        cvvValidator: (p0) {
                          if (p0!.isNotEmpty) {
                            return 'Error';
                          }
                          return null;
                        },
                        formKey: _formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: "",
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: SchedulerBinding.instance.platformDispatcher
                                    .platformBrightness ==
                                Brightness.light
                            ? Colors.black
                            : Colors.white,
                        cardNumberDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: SchedulerBinding
                                              .instance
                                              .platformDispatcher
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: SchedulerBinding
                                              .instance
                                              .platformDispatcher
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white)),
                          labelText: 'Número',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          labelStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          border: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: SchedulerBinding
                                              .instance
                                              .platformDispatcher
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: SchedulerBinding
                                              .instance
                                              .platformDispatcher
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white)),
                          hintStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          labelStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          border: border,
                          labelText: 'Fecha de Exp.',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: SchedulerBinding
                                              .instance
                                              .platformDispatcher
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: SchedulerBinding
                                              .instance
                                              .platformDispatcher
                                              .platformBrightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white)),
                          enabled: false,
                          hintStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          labelStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          border: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabled: false,
                          hintStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          labelStyle: TextStyle(
                              color: SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white),
                          focusedBorder: border,
                          labelText: 'Nombre del Titular',
                        ),
                        onCreditCardModelChange: onCreditCardModel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        child: DropdownMenu<String>(
                          initialSelection: currency,
                          width: 350,
                          menuStyle: const MenuStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          label: const Text("Moneda"),
                          onSelected: (value) {
                            setState(() {
                              currency = value!;
                            });
                          },
                          dropdownMenuEntries: moneda.map((e) {
                            return DropdownMenuEntry<String>(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                              ),
                              value: e,
                              label: e,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: TextFormField(
                                controller: _brandController,
                                decoration: const InputDecoration(
                                  enabled: false,
                                  border: OutlineInputBorder(),
                                  label: Text("Marca"),
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 150,
                            child: DropdownMenu<String>(
                              initialSelection: cardType,
                              enabled: false,
                              width: 150,
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                              ),
                              label: const Text("Tipo de Trajeta"),
                              enableSearch: false,
                              dropdownMenuEntries: types.map((e) {
                                return DropdownMenuEntry<String>(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  ),
                                  value: cardType,
                                  label: cardType,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (cardType == 'CREDITO')
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                      controller: _dueDayController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text(
                                          "Fecha Facturacion",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2100));

                                        if (pickedDate != null) {
                                          debugPrint(pickedDate
                                              .toString()); //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            _dueDayController.text =
                                                pickedDate.toString();
                                          });
                                        }
                                      }),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                      controller: _payDayController,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: Text("Fecha Pago"),
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2100));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            _payDayController.text =
                                                pickedDate.toString();
                                          });
                                        }
                                      }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _interesController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text(
                                        "Tasa Interes",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _lineController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("Linea Credito"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (cardType == 'DEBITO')
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 350,
                              child: TextFormField(
                                  controller: _accountController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Numero Cuenta"),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 350,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _montoController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Monto Mínimo"),
                                  )),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /* --------Para extensión NO BORRAR------------------>
                        if (card.type == "CREDITO")
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addExtensionCard();
                                print("Valido");
                              }
                            },
                            style: FilledButton.styleFrom(
                                foregroundColor:
                                    const Color.fromRGBO(28, 33, 22, 1),
                                backgroundColor: Colors.white,
                                side: const BorderSide()),
                            child: const Text(
                              "Agregar Extensión",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        if (card.type == "CREDITO")
                          const SizedBox(
                            width: 10,
                          ),
                        <------------Para extensión NO BORRAR---------------- */
                          FilledButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await config.systemAlert!.showAlertDialog(
                                    context,
                                    'Editar Tarjeta',
                                    '¿Está seguro de realizar estos cambios?',
                                    () => editCard(card!));
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardScreen(
                                                userToken: widget.userToken,
                                              )));
                                }
                                debugPrint("Valido");
                              }
                            },
                            style: FilledButton.styleFrom(
                              fixedSize: const Size(250, 50),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(28, 33, 22, 1),
                            ),
                            child: const Text(
                              "Editar Tarjeta",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
  4*/
}
2*/
