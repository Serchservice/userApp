import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class Tip2FixWalletScreen extends StatefulWidget {
  final String userAmount;
  const Tip2FixWalletScreen({super.key, required this.userAmount});

  @override
  State<Tip2FixWalletScreen> createState() => _Tip2FixWalletScreenState();
}

class _Tip2FixWalletScreenState extends State<Tip2FixWalletScreen> {
  String cardName = "";
  String cardNumber = "";
  String cardCode = "";
  String date = "";
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      date = creditCardModel.date;
      cardName = creditCardModel.cardName;
      cardCode = creditCardModel.cardCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool userHasBankAccount = true;
    final bank = BankDetail(cardNumber: "5vdvdsd789797979797", id: "F3429Frfvsvbdjik24091",
      cardExpiry: "Wema", cardName: "Evaristus Adimonyemma");

    List<TransactionModel> transactionList = [
      TransactionModel("12/01/2022", senderName: "Evaristus Adimonyemma", amount: 2000, status: "Pending"),
      TransactionModel("12/01/2022", senderName: "Evaristus Adimonyemma", amount: 2000, status: "Sent"),
      TransactionModel("12/01/2022", senderName: "Evaristus Adimonyemma", amount: 2000, status: "Received")
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 1,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Theme.of(context).primaryColor
              )
            ),
            title: SText(
              text: "My Serch Wallet",
              color: Theme.of(context).primaryColorLight,
              size: 24, weight: FontWeight.bold
            ),
            actions: [
              if(userHasBankAccount)
              IconButton(
                onPressed: () => openBankOptions(bankId: bank.id, context: context),
                icon: const Icon(
                  // Icons.more_vert,
                  Icons.delete,
                  size: 24, color: SColors.red
                )
              )
            ],
            expandedHeight: 250,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  //Tip Wallet Box
                  Container(
                    padding: screenPadding,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Image.asset(SImages.wallet, width: 50,),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SText(
                                    text: "My Serch Amount: ",
                                    size: 18,
                                    weight: FontWeight.bold,
                                    color: Scolors.info
                                  ),
                                  SText(
                                    text: widget.userAmount,
                                    size: 18,
                                    weight: FontWeight.bold,
                                    color: Scolors.info
                                  ),
                                ]
                              ),
                            ]
                          ),
                        )
                      ],
                    )
                  ),
            
                  //Button to popup the bottomSheet for the user to enter account number for funds transfer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SButton(
                          text: "Deposit",
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                          textWeight: FontWeight.bold,
                          textSize: 14,
                          borderRadius: 3,
                          onClick: () => openWithdrawDialog(
                            context: context,
                            userHasBankAccount: userHasBankAccount,
                            bank: bank
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ),
          //User Bank Account for withdrawal
          if(userHasBankAccount == true)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
              child: BankBox(
                bank: bank, isGrid: false,
                onMoreOptions: () {
                  debugShow(bank.id);
                  openBankOptions(bankId: bank.id, context: context);
                },
              )
            )
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  //For the User to add a bank account
                  if(userHasBankAccount == false || bank.isBlank!)
                  Material(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () => addBankAccount(context: context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_home, color: Theme.of(context).primaryColorLight, size: 26),
                            const SizedBox(width: 5),
                            SText(
                              text: "Add Bank Card",
                              size: 16,
                              weight: FontWeight.bold,
                              color: Theme.of(context).primaryColorLight
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Scolors.info3,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const SText(
                      text: "NOTE: Transaction history within 30 days is shown in the table history below.",
                      color: SColors.black,
                      weight: FontWeight.bold,
                      size: 14
                    )
                  ),
                  const SizedBox(height: 20),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SText(
                        text: "Transaction History",
                        color: Theme.of(context).primaryColorLight,
                        size: 18, weight: FontWeight.bold
                      ),
                    ],
                  ),
                ]
              )
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  return TransactionBox(model: transactionList[index]);
                }),
                childCount: transactionList.length
              )
            ),
          ),

          if(transactionList.isEmpty)
          SliverToBoxAdapter(
            child: Column(
              children: const [
                Center(
                  child: SText.center(
                    text: "No transactions yet",
                    color: SColors.hint,
                    size: 20,
                  ),
                ),
                SizedBox(height: 40)
              ],
            ),
          )
          else
          const SliverToBoxAdapter(child: SizedBox(height: 40))
        ],
      )
    );
  }

  TableRow tableHeader(List<String> headers, {bool isHeader = false}) => TableRow(
    children: headers.map((e) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8),
      child: Center(
        child: SText(
          text: e,
          size: isHeader ? 16 : 14, weight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: e.toString() == "Pending" ? Scolors.info2 : e.toString() == "Sent" ? Scolors.error
          : e.toString() == "Received" ? Scolors.success : Theme.of(context).primaryColorLight
        ),
      ),
    )).toList()
  );

  void openWithdrawDialog({
    required BuildContext context,
    required bool userHasBankAccount,
    required BankDetail bank,
  }){
    final cardCode = TextEditingController();
    final amount = TextEditingController();
    final formKey = GlobalKey<FormState>();

    if(userHasBankAccount) {
      //Show the user's account number/s for the user to choose which account to transfer money to.
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
          builder:(context, setState) => Container(
            padding: screenPadding,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SText(
                        text: "Complete your card details",
                        size: 20,
                        weight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SFormField(
                              labelText: bank.cardName,
                              formName: "Card Owner Name",
                              enabled: false,
                              cursorColor: Theme.of(context).primaryColor,
                              fillColor: Theme.of(context).backgroundColor,
                              formStyle: STexts.normalForm(context),
                              formColor: Theme.of(context).primaryColor,
                            ),
                            SFormField(
                              labelText: bank.cardNumber,
                              formName: "Card Number",
                              enabled: false,
                              cursorColor: Theme.of(context).primaryColor,
                              fillColor: Theme.of(context).backgroundColor,
                              formStyle: STexts.normalForm(context),
                              formColor: Theme.of(context).primaryColor,
                            ),
                            SFormField(
                              labelText: bank.cardExpiry,
                              formName: "Card Expiry Date",
                              enabled: false,
                              cursorColor: Theme.of(context).primaryColor,
                              fillColor: Theme.of(context).backgroundColor,
                              formStyle: STexts.normalForm(context),
                              formColor: Theme.of(context).primaryColor,
                            ),
                            SFormField(
                              labelText: "235",
                              formName: "Card Code",
                              controller: cardCode,
                              cursorColor: Theme.of(context).primaryColor,
                              fillColor: Theme.of(context).backgroundColor,
                              formStyle: STexts.normalForm(context),
                              formColor: Theme.of(context).primaryColor,
                              enabledBorderColor: Theme.of(context).primaryColor,
                            ),
                            SFormField(
                              labelText: "5,000",
                              formName: "Deposit Amount",
                              controller: amount,
                              cursorColor: Theme.of(context).primaryColor,
                              fillColor: Theme.of(context).backgroundColor,
                              formStyle: STexts.normalForm(context),
                              formColor: Theme.of(context).primaryColor,
                              enabledBorderColor: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 20),
                            SButton(
                              text: "Deposit",
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(12.0),
                              textWeight: FontWeight.bold,
                              textSize: 18,
                              onClick: () => {},
                            ),
                          ]
                        )
                      ),
                    ],
                  ),
                ),
              ]
            ),
          )
        )
      );
    } else {
      ///Show the user that he has no bank account attached to his profile, give him an option to add a bank account
      ///Also tell the user to wait for 30days and run 5 t2f features before being able to withdraw.
      addBankAccount(context: context);
    }
  }
}

addBankAccount({
  required BuildContext context,
}) async {
  final formKey = GlobalKey<FormState>();
  final amount = TextEditingController();
  String cardName = "";
  String cardNumber = "";
  String cardCode = "";
  String date = "";
  bool selected = false;

  showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: StatefulBuilder(
        builder:(context, setState) => Container(
          padding: screenPadding,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SText(
                  text: "Provide a bank card for deposits",
                  size: 20,
                  weight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    PayForm(
                      cardName: cardName,
                      cardNumber: cardNumber,
                      cardCode: cardCode,
                      date: date,
                      widget: selected ? SFormField(
                        labelText: "5,000",
                        formName: "Deposit Amount",
                        controller: amount,
                        cursorColor: Theme.of(context).primaryColor,
                        fillColor: Theme.of(context).backgroundColor,
                        formStyle: STexts.normalForm(context),
                        formColor: Theme.of(context).primaryColor,
                        enabledBorderColor: Theme.of(context).primaryColor,
                      ) : null,
                      onCreditCardModelChange: (CreditCardModel? creditCardModel) {
                        setState(() {
                          cardNumber = creditCardModel!.cardNumber;
                          date = creditCardModel.date;
                          cardName = creditCardModel.cardName;
                          cardCode = creditCardModel.cardCode;
                        });
                      },
                      formKey: formKey
                    ),
                    const SizedBox(height: 12),
                    Material(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                      child: InkWell(
                        onTap:() => setState(() => selected = !selected),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12.0, 12.0, 12.0),
                          child: Row(
                            children: [
                              Icon(
                                selected ? Icons.check_box_outlined : Icons.check_box_outline_blank_rounded,
                                color: selected ? SColors.green : SColors.hint, size: 24
                              ),
                              const SizedBox(width: 10),
                              SText(
                                text: "Deposit money as well",
                                size: 16,
                                weight: FontWeight.bold,
                                color: Theme.of(context).primaryColorLight
                              )
                            ]
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SButton(
                        text: selected ? "Save and Deposit" : "Save my bank card",
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        textWeight: FontWeight.bold,
                        textSize: 18,
                        onClick: () => {},
                      ),
                    ),
                  ]
                ),
              ]
            ),
          ),
        )
      ),
    )
  );
}




///Popup for bank account deleting
///
void openBankOptions({
  required BuildContext context,
  required dynamic bankId,
}) async {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => StatefulBuilder(
      builder:(context, setState) => AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: SText(
          text: "Are you sure you want to delete this Bank Account?",
          size: 16,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight,
        ),
        actions: [
          SBtn(onClick: () {}, text: "Yes", buttonColor: Theme.of(context).backgroundColor,),
          SBtn(onClick: () => Get.back(), text: "No", buttonColor: Theme.of(context).backgroundColor,)
        ],
      )
    )
  );
}