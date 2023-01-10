import 'package:flutter/material.dart';
import 'package:user/lib.dart';

class BankBox extends StatelessWidget{
  final BankDetail bank;
  final bool isGrid;
  final void Function()? onLongPress;
  final void Function()? onPress;
  final void Function()? onMoreOptions;
  const BankBox({ super.key, required this.bank, this.isGrid = false, this.onPress, this.onLongPress, this.onMoreOptions});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        // color: Theme.of(context).backgroundColor,
        child: InkWell(
          onTap: onPress,
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(SImages.ccbg),
                fit: BoxFit.cover
              )
            ),
            child: isGrid
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SText(
                  color: SColors.white,
                  text: bank.cardName,
                  size: 18, weight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                SText(
                  color: SColors.white,
                  text: "${bank.cardNumber.substring(0, 4)}****",
                  size: 16, weight: FontWeight.bold,
                ),
                const SizedBox(height: 5),
                SText(
                  color: SColors.white,
                  text: bank.cardExpiry,
                  size: 16, weight: FontWeight.bold,
                ),
                const SizedBox(height: 5),
                //Icon for more options and Bank Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(SImages.layers, width: 25,),
                    IconButton(
                      onPressed: onMoreOptions,
                      icon: const Icon(
                        // Icons.more_vert,
                        Icons.delete,
                        size: 24, color: Scolors.error
                      )
                    )
                  ],
                )
              ],
            )
            : Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(SImages.layers, width: 25,),
                        const SizedBox(width: 10),
                        SText(
                          color: SColors.white,
                          text: bank.cardName,
                          size: 22, weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SText(
                      color: SColors.white,
                      text: "${bank.cardNumber.substring(0, 7)}****",
                      size: 18, weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 5),
                    SText(
                      color: SColors.white,
                      text: bank.cardExpiry,
                      size: 14, weight: FontWeight.bold,
                    ),
                  ]
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

class CreditCardModel {

  CreditCardModel(this.cardNumber, this.date, this.cardName, this.cardCode,);

  String cardNumber = '';
  String date = '';
  String cardName = '';
  String cardCode = '';
}

class BankDetail{
  final String cardName;
  final String cardNumber;
  final String cardExpiry;
  final String id;

  BankDetail({required this.cardName, required this.cardNumber, required this.cardExpiry, required this.id});
}