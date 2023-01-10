import 'package:flutter/material.dart';
import 'package:user/lib.dart';

class SPayCard extends StatefulWidget {
  final String cardName;
  final String cardNumber;
  final String cardCode;
  final String date;
  final double width;
  final double height;
  const SPayCard({
    super.key, required this.cardName, required this.cardNumber, required this.cardCode, required this.date,
    this.width = 200, this.height = 180
  });

  @override
  State<SPayCard> createState() => _SPayCardState();
}

class _SPayCardState extends State<SPayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage(SImages.ccbg),fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.blue,width: 2,),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SText(text: "Name:", size: 16, weight: FontWeight.bold,),
                  const SizedBox(width: 10,),
                  SText(text: widget.cardName.isEmpty ? "Card Holder Name" : widget.cardName, size: 16, weight: FontWeight.bold,)
                ],
              ),
              // Image.asset(SImages.chip, width: 30,),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SText(text: "Number:", size: 16, weight: FontWeight.bold,),
                  const SizedBox(width: 10,),
                  SText(text: widget.cardNumber.isEmpty ? "XXXX XXXX XXXX XXXX" : widget.cardNumber, size: 16, weight: FontWeight.bold,),
                ],
              ),
              getCardTypeIcon(widget.cardNumber)
            ],
          ),
          Row(
            children: [
              const SText(text: "CVV:", size: 16, weight: FontWeight.bold,),
              const SizedBox(width: 10,),
              SText(text: widget.cardCode.isEmpty ? "Card Holder Code" : widget.cardCode, size: 16, weight: FontWeight.bold,),
            ],
          ),
          Row(
            children: [
              const SText(text: "Card Expiry Date:", size: 16, weight: FontWeight.bold,),
              const SizedBox(width: 10,),
              SText(text: widget.date.isEmpty ? "Card Expiry Date" : widget.date, size: 16, weight: FontWeight.bold,),
            ],
          ),
        ],
      ),
    );
  }
}