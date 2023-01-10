import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';

class SubscribeSelectScreen extends StatefulWidget {
  const SubscribeSelectScreen({super.key});

  @override
  State<SubscribeSelectScreen> createState() => _SubscribeSelectScreenState();
}

class _SubscribeSelectScreenState extends State<SubscribeSelectScreen> {
  addplan(context, plan) async {
    // await AuthIDB().addplan(plan: widget.value.toString());
    Navigator.of(context).push((PlanRouteScreen.route(plan)));
  }
// offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 4)), (route) => false)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SText.center(
          text: "Pick a plan",
          size: 20,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            const SizedBox(height: 20),
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
            SButtonText(
              text: "Need help selecting?",
              textButton: "Read about Serch plans",
              textColor: Theme.of(context).primaryColor,
              textButtonColor: SColors.lightPurple,
              onClick: () {},
            ),
          ],
        ),
      )
    );
  }
}

class SubscribePayScreen extends StatefulWidget {
  static Route route(Plans plan) => MaterialPageRoute(
    builder: (context) => SubscribePayScreen(value: plan)
  );

  final dynamic value;
  const SubscribePayScreen({super.key, this.value});

  @override
  State<SubscribePayScreen> createState() => _SubscribePayScreenState();
}

class _SubscribePayScreenState extends State<SubscribePayScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}