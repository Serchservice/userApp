import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';

class SelectPlanForm extends StatefulWidget {
  const SelectPlanForm({super.key});

  @override
  State<SelectPlanForm> createState() => _SelectPlanFormState();
}

class _SelectPlanFormState extends State<SelectPlanForm> {
  addplan(context, plan) async {
    // await AuthIDB().addplan(plan: widget.value.toString());
    Navigator.of(context).push(PlanRouteScreen.route(plan));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 40),
        SText(
          text: "Best Plans, Best Choices",
          color: Theme.of(context).primaryColor,
          size: 24,
          weight: FontWeight.w900,
        ),
        const SizedBox(height: 5),
        const Padding(
          padding: horizontalPadding,
          child: SText.center(
            text: "We have curated a list of plans suitable for you at any time.",
            color: SColors.hint,
            size: 16,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          children: [
            SPlanCard(
              title: "Aries",
              price: "\$10",
              onClick: () => addplan(context, Plans.aries),
              image: SImages.aries
            ),
            SPlanCard(
              title: "Libra",
              price: "\$10",
              onClick: () => addplan(context, Plans.libra),
              image: SImages.libra
            ),
            SPlanCard(
              title: "Aqua",
              price: "\$10",
              onClick: () => addplan(context, Plans.aqua),
              image: SImages.aqua
            ),
            SPlanCard(
              title: "Virgo",
              price: "\$10",
              onClick: () => addplan(context, Plans.virgo),
              image: SImages.virgo
            ),
          ],
        ),
        const SizedBox(height: 20),
        SText(
          text: "Don't feel like subscribing at the moment?",
          color: Theme.of(context).primaryColor,
          size: 18,
        ),
        const SizedBox(height: 40),
        SButton(
          text: "Start 14-days free trial",
          width: width,
          textWeight: FontWeight.bold,
          textSize: 18,
          onClick: () => Get.to(() => const ActivateFreeTrialScreen())
        ),
        const SizedBox(height: 20),
        SButtonText(
          text: "Need help selecting?",
          textButton: "Read about Serch plans",
          textColor: Theme.of(context).primaryColor,
          textButtonColor: SColors.lightPurple,
          onClick: () {},
        ),
      ],
    );
  }
}