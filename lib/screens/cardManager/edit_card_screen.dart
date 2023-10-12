import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:spedtracker_app/components/alerts/alert_config.dart';
import 'package:spedtracker_app/models/card_list.dart';
import 'package:spedtracker_app/models/card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:spedtracker_app/screens/cardManager/add_card_screen.dart';
import 'package:spedtracker_app/screens/cardManager/card_screen.dart';

class EditCardScreen extends StatefulWidget {
  final String userToken;
  final CardModel card;
  const EditCardScreen(
      {super.key, required this.userToken, required this.card});

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  late CardModel card;
  OutlineInputBorder border = const OutlineInputBorder();
  final _formKey = GlobalKey<FormState>();
  final AlertConfig config = AlertConfig.instance;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardService = '';
  String cardType = '';
  late CardType brand;
  List<String> types = ['CREDITO', 'DEBITO', 'CREDITO EXTENSIÓN'];
  CardModelList cardList = CardModelList.instance;
  final TextEditingController _brandController = TextEditingController();

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

  void editCard() {
    List<String> date = expiryDate.split("/");

    card.cardHolder = cardHolderName;
    card.expMonth = date[0];
    card.expYear = date[1];
    card.operadoraFinanciera = cardService;
    card.numeroTarjeta = cardNumber;

    cardList.editCard(card);
  }

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

  @override
  void initState() {
    super.initState();
    card = widget.card;
    cardNumber = card.numeroTarjeta;
    expiryDate = '${card.expMonth}/${card.expYear}';
    cardHolderName = card.cardHolder;
    cardType = card.type;
    cardService = card.operadoraFinanciera;
    print(card.type);
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        FilledButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await config.systemAlert!.showAlertDialog(
                                  context,
                                  'Editar Tarjeta',
                                  '¿Está seguro de realizar estos cambios?',
                                  () => editCard());
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
