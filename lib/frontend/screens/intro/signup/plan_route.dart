import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';

class PlanRouteScreen extends StatefulWidget {
  static Route route(Plans plan) => MaterialPageRoute(
    builder: (context) => PlanRouteScreen(value: plan)
  );

  final dynamic value;
  const PlanRouteScreen({super.key, this.value});

  @override
  State<PlanRouteScreen> createState() => _PlanRouteScreenState();
}

class _PlanRouteScreenState extends State<PlanRouteScreen> {
  final _formKey = GlobalKey<FormState>();
  List<int> selectedService = [];
  int selected = -1;
  bool error = false;
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

  finishSignup() async {
    if(!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if(widget.value == Plans.aqua){
      if(selectedService.isEmpty || selectedService.length <= 2){
        return setState(() => error = true);
      }else if(selectedService.contains(0) && selectedService.contains(1) && selectedService.contains(2)){
        // await AuthIDB().addthree(service: "Electrician", service1: "Mechanic", service2: "Plumber");
      } else if(selectedService.contains(0) && selectedService.contains(1) && selectedService.contains(3)){
        // await AuthIDB().addthree(service: "Electrician", service1: "Mechanic", service2: "Shopper");
      } else if(selectedService.contains(0) && selectedService.contains(2) && selectedService.contains(3)){
        // await AuthIDB().addthree(service: "Electrician", service1: "Plumber", service2: "Shopper");
      } else {
        // await AuthIDB().addthree(service: "Mechanic", service1: "Plumber", service2: "Shopper");
      }
    } else if(widget.value == Plans.libra){
      if(selectedService.isEmpty || selectedService.length == 1){
        return setState(() => error = true);
      }else if(selectedService.contains(0) && selectedService.contains(1)){
        // await AuthIDB().addtwo(service: "Electrician", service1: "Mechanic");
      } else if(selectedService.contains(0) && selectedService.contains(2)){
        // await AuthIDB().addtwo(service: "Electrician", service1: "Plumber");
      } else if(selectedService.contains(0) && selectedService.contains(3)){
        // await AuthIDB().addtwo(service: "Electrician", service1: "Shopper");
      } else if(selectedService.contains(1) && selectedService.contains(2)){
        // await AuthIDB().addtwo(service: "Mechanic", service1: "Plumber");
      } else if(selectedService.contains(1) && selectedService.contains(3)){
        // await AuthIDB().addtwo(service: "Mechanic", service1: "Plumber");
      } else {
        // await AuthIDB().addtwo(service: "Shopper", service1: "Plumber");
      }
    } else if(widget.value == Plans.aries){
      if(selected.isEqual(-1)){
        return setState(() => error = true);
      }else if(selected == 0){
        // await AuthIDB().addone(service: "Electrician");
      } else if(selected == 1){
        // await AuthIDB().addone(service: "Mechanic");
      } else if(selected == 2){
        // await AuthIDB().addone(service: "Plumber");
      } else {
        // await AuthIDB().addone(service: "Personal Shopper");
      }
    } else {
      // await AuthIDB().addone(service: "All Categories");
    }

    Get.offAll(() => const SignupConfirmScreen());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor
          )
        ),
        centerTitle: true,
        title: SText.theme(
          text: widget.value == Plans.aqua ? "Select three preferred services"
          : widget.value == Plans.aries ? "Select one preferred service"
          : widget.value == Plans.libra ? "Select two preferred services"
          : "You are at the top of the game",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Column(
              children: [
                widget.value == Plans.aqua ? Aqua(selectedService: selectedService)
                : widget.value == Plans.libra ? Libra(selectedService: selectedService)
                : widget.value == Plans.virgo ? const Virgo()
                : Aries(selected: selected),
                SText.center(
                  text: "Enter Card Details to Proceed",
                  color: Theme.of(context).primaryColor,
                  size: 18,
                  weight: FontWeight.bold
                ),
                const SizedBox(height: 20),
                SPayCard(
                  cardCode: cardCode,
                  cardName: cardName,
                  cardNumber: cardNumber,
                  date: date,
                  width: width
                ),
                PayForm(
                  cardCode: cardCode,
                  cardName: cardName,
                  cardNumber: cardNumber,
                  date: date,
                  formKey: _formKey,
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                const SizedBox(height: 10),
                error ? const SText.center(
                  text: "Oops!, You seem to have omitted something",
                  color: SColors.red,
                  size: 14,
                  weight: FontWeight.bold
                ) : Container(),
                const SizedBox(height: 40),
                SButton(
                  text: "Enjoy",
                  width: width,
                  padding: const EdgeInsets.all(12),
                  textWeight: FontWeight.bold,
                  textSize: 18,
                  onClick: () => finishSignup(),
                ),
                const SizedBox(height: 20),
              ],
            )
          )
        )
      )
    );
  }
}