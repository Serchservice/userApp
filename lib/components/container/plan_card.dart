import 'package:flutter/material.dart';
import 'package:user/lib.dart';

class SPlanCard extends StatelessWidget{
  final String title;
  final String price;
  final String image;
  final VoidCallback? onClick;
  final double width;
  const SPlanCard({
    super.key, required this.title, required this.price, required this.image, this.width = 50, this.onClick
  });

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(5.0),
        width: 100,
        decoration: BoxDecoration(
          color: SColors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Image.asset(image, width: width),
            const SizedBox(height: 10),
            SText.center(text: title, size: 18, weight: FontWeight.w900),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  SImages.dollar,
                  width: 20
                ),
                const SizedBox(width: 10.0),
                SText(text: price, size: 16, weight: FontWeight.bold)
              ]
            )
          ],
        )
      ),
    );
  }
}