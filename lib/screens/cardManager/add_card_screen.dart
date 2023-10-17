import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:spedtracker_app/services/card_service.dart';
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
  List<CardModel> cards = [];
  OutlineInputBorder border = const OutlineInputBorder();
  final _formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardService = '';
  List<String> types = [];
  List<String> moneda = ['SOLES', 'DOLARES'];
  CardModelList cardList = CardModelList.instance;
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

  void createCard() async {
    List<String> date = expiryDate.split("/");
    String idTarjeta = uuid.v4();
    CardModel newCard;
    DateTime expDate = DateTime.parse("20${date[1]}-${date[0]}-01");
    if (cardType == 'DEBITO') {
      newCard = DebitCard(idTarjeta, cardNumber, currency, expDate, cardService,
          '0112971372819827', 1000);
    } else {
      newCard = CreditCard(
        idTarjeta,
        cardNumber,
        currency,
        expDate,
        cardService,
        DateTime.parse("2023-02-10"),
        DateTime.parse("2023-02-05"),
        0.55,
        10000,
      );
    }
    await CardService().createCard(widget.userToken, newCard);
    cardList.cardList.add(newCard);
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => CardScreen(userToken: widget.userToken)),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint(DateTime.parse("2023-02-01").toString().split('-')[1]);
    debugPrint(
        DateTime.parse("2023-02-01").toString().split('-')[0].split('0')[1]);
    if (widget.isExtension) {
      types.add('CREDITO EXTENSIÓN');
      cardType = types.first;
    } else {
      types.addAll(['CREDITO', 'DEBITO']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Gestión de Tarjetas",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
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
                      textColor: Colors.black,
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Número',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        border: border,
                      ),
                      expiryDateDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        border: border,
                        labelText: 'Fecha de Exp.',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        enabled: false,
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        border: border,
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: border,
                        enabledBorder: border,
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
                        initialSelection: cardType,
                        width: 350,
                        menuStyle: const MenuStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        label: const Text("Moneda"),
                        enabled: !widget.isExtension,
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
                            label: const Text("Tipo de Trajeta"),
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
                                        print(
                                            pickedDate); //formatted date output using intl package =>  2021-03-16
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
                    FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            cardType != '') {
                          createCard();
                          print("Valido");
                        }
                      },
                      style: FilledButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(28, 33, 22, 1)),
                      child: const Text(
                        "Añadir Tarjeta",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
