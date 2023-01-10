import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';

class SUserPlan extends StatelessWidget {
  final bool aries;
  final bool aqua;
  final bool libra;
  final bool redLight;
  final bool warningLight;
  final bool freePlan;
  final String freePlanText;
  final String serviceOneText;
  final String serviceTwoText;
  final String serviceThreeText;
  const SUserPlan({
    super.key, this.aries = false, this.aqua = false, this.libra = false, this.freePlan = true, required this.freePlanText,
    this.serviceOneText = "", this.serviceTwoText = "", this.serviceThreeText = "", this.redLight = false, this.warningLight = false
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: aries ? SColors.aries
      : aqua ? SColors.aqua
      : libra ? SColors.libra
      : SColors.virgo,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        onTap: freePlan ? null : () => Get.to(() => const SubscribeScreen()),
        child: Container(
          padding: const EdgeInsets.all(18),
          child: freePlan ? Column(
            children: [
              Wrap(
                children: [
                  const SText(
                    text: "You are running on a free plan and you have ",
                    size: 16
                  ),
                  SText(
                    text: freePlanText,
                    size: 16,
                    color: redLight ? SColors.red : warningLight ? SColors.yellow : SColors.green
                  ),
                  const SText(
                    text: " remaining.",
                    size: 16
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SButton(
                text: "Subscribe to a plan now",
                textSize: 16,
                onClick: () => Get.to(() => const SubscribeSelectScreen()),
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
              )
            ],
          ) : Row(
            children: [
              Image.asset(SImages.verified, width: 50),
              const SizedBox(width: 10,),
              const Expanded(child: SText(text: "Tap this box to see your subscription plan", size: 16))
            ],
          )
        ),
      ),
    );
  }
}

class SServiceCard extends StatelessWidget{
  final String title;
  final String image;
  final dynamic value;
  final double width;
  const SServiceCard({
    super.key, required this.title, required this.image, this.width = 50, this.value
  });

  addplan(context) async {
    await AuthIDB().addservice(
      service: value == Services.barber ? "Barber"
      : value == Services.electrician ? "Electrician"
      : value == Services.mechanic ? "Mechanic"
      : "Plumber"
    );
    Get.to(() => const AdditionalScreen());
  }

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () => addplan(context),
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
            SText.center(
              text: title == "Electrician"
              ? "Enjoy more jobs on the go with your ${title.toLowerCase().substring(0, 8)}al skills"
              : title == "Plumber"
              ? "Enjoy more jobs on the go with your ${title.toLowerCase().substring(0, 5)}ing skills"
              : title == "Barber"
              ? "Enjoy more jobs on the go with your ${title.toLowerCase().substring(0, 4)}ing skills"
              : "Enjoy more jobs on the go with your ${title.toLowerCase()} skills"
            ),
          ],
        )
      ),
    );
  }
}

