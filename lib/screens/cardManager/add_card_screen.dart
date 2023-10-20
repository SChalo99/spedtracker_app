import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:spedtracker_app/components/background/background.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/models/user_singleton.dart';
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:spedtracker_app/services/card_service.dart';
import 'package:spedtracker_app/services/notification_service.dart';
import 'package:uuid/uuid.dart';

class AddCardScreen extends StatefulWidget {
  final String userToken;
  final bool isExtension;
  const AddCardScreen(
      {super.key, required this.userToken, this.isExtension = false});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}


class _AddCardScreenState extends State<AddCardScreen> {
  /*3
  List<CardModel> cards = [];
  OutlineInputBorder border = const OutlineInputBorder();
  final _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  UserSingleton user = UserSingleton.instance;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardService = '';
  List<String> types = [];
  List<String> moneda = ['SOLES', 'DOLARES'];

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _payDayController = TextEditingController();
  final TextEditingController _dueDayController = TextEditingController();
  final TextEditingController _interesController = TextEditingController();
  final TextEditingController _lineController = TextEditingController();
  String currency = '';
  String cardType = '';
  late CardType brand;
  3*/
  /*9
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
  9*/

  /*10
  void createCard() async {
    List<String> date = expiryDate.split("/");
    String idTarjeta = uuid.v4();
    CardModel newCard;
    DateTime expDate = DateTime.parse("20${date[1]}-${date[0]}-01");
    DateTime expDateNotification = expDate.subtract(const Duration(days: 10));

    debugPrint(expDateNotification.toString());
    int cardNumLenght = cardNumber.length;
    if (cardType == 'DEBITO') {
      newCard = DebitCard(idTarjeta, cardNumber, currency, expDate, cardService,
          _accountController.text, double.parse(_montoController.text));
    } else {
      newCard = CreditCard(
        idTarjeta,
        cardNumber,
        currency,
        expDate,
        cardService,
        DateTime.parse(_dueDayController.text),
        DateTime.parse(_payDayController.text),
        double.parse(_interesController.text),
        double.parse(_lineController.text),
      );
      debugPrint(newCard.idTarjeta);
    }
    await CardService().createCard(widget.userToken, newCard);
    createNotifications(cardNumLenght, expDateNotification);

    if (context.mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CardScreen(userToken: widget.userToken)));
    }
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
  10*/

  /*4
  @override
  void initState() {
    super.initState();
    cardHolderName = "${user.currentUser.nombre} ${user.currentUser.apellido}";
    if (widget.isExtension) {
      types.add('CREDITO EXTENSIÓN');
      cardType = types.first;
    } else {
      types.addAll(['CREDITO', 'DEBITO']);
    }
  }
  4*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*DELETE ALL APPBAR--8
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_new,
      //       color: Colors.white,
      //     ),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: const Text(
      //     "Gestión de Tarjetas",
      //     style: TextStyle(
      //         color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.black,
      // ),
      DELETE ALL APPBAR--8*/
      body: Stack(alignment: Alignment.bottomCenter, children: [
        /*7
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
        7*/

        /*6
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
                          labelText: 'Número',
                          hintText: 'XXXX XXXX XXXX XXXX',
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
                          enabled: false,
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
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          enabled: false,
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
                          width: 350,
                          menuStyle: const MenuStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          inputDecorationTheme: const InputDecorationTheme(),
                          label: const Text(
                            "Moneda",
                          ),
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
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide()),
                                  label: Text("Marca"),
                                )),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 150,
                            child: DropdownMenu<String>(
                              initialSelection: cardType,
                              width: 150,
                              menuStyle: const MenuStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                              ),
                              label: const Text(
                                "Tipo de Trajeta",
                              ),
                              enabled: !widget.isExtension,
                              onSelected: (value) {
                                setState(() {
                                  cardType = value!;
                                });
                              },
                              dropdownMenuEntries: types.map((e) {
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
                        ],
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
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
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
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
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
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
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
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                      labelText: "Linea Credito",
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
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
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
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                    labelText: "Monto Mínimo",
                                  )),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              cardType != '') {
                            createCard();
                            print("Valido");
                          }
                        },
                        style: FilledButton.styleFrom(
                            fixedSize: const Size(250, 50),
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(28, 33, 22, 1)),
                        child: const Text(
                          "Añadir Tarjeta",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
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
        6*/
      ]),
    );
  }
}

