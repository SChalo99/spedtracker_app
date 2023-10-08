import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:spedtracker_app/models/credit_card_model.dart';
import 'package:spedtracker_app/models/debit_card_model.dart';
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';
import 'package:spedtracker_app/services/card_service.dart';

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
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardService = '';
  List<String> types = [];
  CardModelList cardList = CardModelList.instance;
  final TextEditingController _brandController = TextEditingController();
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
    CardModel newCard;
    if (cardType == 'DEBITO') {
      newCard = DebitCard(
          (cardList.cardList.length + 1).toString(),
          cardNumber,
          'Soles',
          cardType,
          cardHolderName,
          date[0],
          date[1],
          cardService,
          '0112971372819827');
    } else if (cardType == 'CREDITO') {
      newCard = CreditCard(
        (cardList.cardList.length + 1).toString(),
        cardNumber,
        'Soles',
        cardType,
        cardHolderName,
        date[0],
        date[1],
        cardService,
        DateTime.parse("2023-02-10"),
        DateTime.parse("2023-02-5"),
        0.55,
      );
    } else {
      newCard = CreditCard(
        (cardList.cardList.length + 1).toString(),
        cardNumber,
        'Soles',
        cardType,
        cardHolderName,
        date[0],
        date[1],
        cardService,
        DateTime.parse("2023-02-10"),
        DateTime.parse("2023-02-5"),
        0.55,
      );
    }
    //await CardService().createCard(widget.userToken, newCard);
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
