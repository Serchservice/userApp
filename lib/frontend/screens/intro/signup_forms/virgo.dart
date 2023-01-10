import 'package:flutter/material.dart';
import 'package:user/lib.dart';


///For all services
class Virgo extends StatefulWidget {
  const Virgo({super.key});

  @override
  State<Virgo> createState() => _VirgoState();
}

class _VirgoState extends State<Virgo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: SColors.yellow,
            borderRadius: BorderRadius.circular(5)
          ),
          child: const SText(
            text: "You are accessing the full features of Serch.",
            color: SColors.white,
            size: 16,
            weight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}