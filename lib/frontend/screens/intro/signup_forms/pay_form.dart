import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/lib.dart';

class PayForm extends StatefulWidget {
  final String cardName;
  final String cardNumber;
  final String cardCode;
  final String date;
  final String cardNameText;
  final String cardNumberText;
  final String cardCodeText;
  final String cardDateText;
  final Widget? widget;
  final Color? color;
  final GlobalKey<FormState> formKey;
  final void Function(CreditCardModel) onCreditCardModelChange;
  const PayForm({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.cardCode,
    required this.date,
    required this.onCreditCardModelChange,
    required this.formKey, this.color,
    this.cardNameText = "John Doe",
    this.cardNumberText = "5045 5435 4543 5435",
    this.cardCodeText = "405",
    this.cardDateText = "MM/YY", this.widget
  });

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  late String cardNumber;
  late String date;
  late String cardName;
  late String cardCode;
  bool isVisible = false;
  bool visible = false;

  late void Function(CreditCardModel) onCreditCardModelChange;
  late CreditCardModel creditCardModel;

  final MaskedTextController cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController dateController = MaskedTextController(mask: '00/00');
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardCodeController = MaskedTextController(mask: '0000');

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    date = widget.date;
    cardName = widget.cardName;
    cardCode = widget.cardCode;
    creditCardModel = CreditCardModel(cardNumber, date, cardName, cardCode);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cardNumberController.addListener(() {
      setState(() {
        cardNumber = cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    dateController.addListener(() {
      setState(() {
        date = dateController.text;
        creditCardModel.date = date;
        onCreditCardModelChange(creditCardModel);
      });
    });

    cardNameController.addListener(() {
      setState(() {
        cardName = cardNameController.text;
        creditCardModel.cardName = cardName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    cardCodeController.addListener(() {
      setState(() {
        cardCode = cardCodeController.text;
        creditCardModel.cardCode = cardCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SFormField(
            labelText: widget.cardNameText,
            controller: cardNameController,
            inputAction: TextInputAction.next,
            keyboard: TextInputType.name,
            formName: "Card Holder Name",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
          ),
          SFormField.password(
            labelText: widget.cardNumberText,
            controller: cardNumberController,
            keyboard: TextInputType.number,
            obscureText: !isVisible,
            inputAction: TextInputAction.next,
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            formName: "Card Holder Name",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
            icon: isVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            // myValidators: Validators.validateCardNumber
          ),
          SFormField.password(
            labelText: widget.cardCodeText,
            controller: cardCodeController,
            keyboard: TextInputType.number,
            obscureText: !visible,
            inputAction: TextInputAction.next,
            onPressed: () {
              setState(() {
                visible = !visible;
              });
            },
            formName: "Card CVV Code",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
            icon: visible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            // myValidators: Validators.validateCardNumber
          ),
          SFormField(
            labelText: widget.cardDateText,
            controller: dateController,
            // validate: Validators.validateCardDate,
            keyboard: TextInputType.number,
            inputAction: TextInputAction.done,
            formName: "Card Expiry Date",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
          ),
          Container(child: widget.widget)
      ],
    ));
  }
}