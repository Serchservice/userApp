import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';

class SelectedServiceModel{
  final String service;
  SelectedServiceModel({required this.service});
}

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  final formKey = GlobalKey<FormState>();
  bool canChangeService = true;
  bool changeService = false;
  bool canChange = true;
  bool aries = false;
  bool aqua = true;
  bool libra = false;

  List<SelectedServiceModel> services = [
    SelectedServiceModel(service: "Electrician"),
    SelectedServiceModel(service: "Plumber"),
    SelectedServiceModel(service: "Barber"),
  ];
  List<int> selectedService = [];
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SText.center(
          text: "My Subscription Plan",
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
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Avatar(
                    radius: 60,
                    image: aries ? SImages.aries : libra ? SImages.libra : aqua ? SImages.aqua : SImages.virgo,
                  ),
                  const SizedBox(height: 15),
                  SText.center(
                    text: aries ? "Aries" : libra ? "Libra" : aqua ? "Aqua" : "Virgo",
                    size: 30,
                    weight: FontWeight.bold,
                    color: aries ? SColors.aries : libra ? SColors.libra : aqua ? SColors.aqua : SColors.virgo
                  ),
                  const SizedBox(height: 30),
                  if(aries || libra || aqua)
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const SText(
                      text: "NOTE: You can change to a new service you want to receive every 14 days.",
                      color: SColors.hint,
                      weight: FontWeight.bold,
                      size: 12
                    )
                  )
                  else
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const SText(
                      text: "NOTE: You have everything in the plan you are running at the moment. Hope you have a wonderful experience.",
                      color: SColors.hint,
                      weight: FontWeight.bold,
                      size: 12
                    )
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SText(
                    text: "My ${aries ? "Service" : "Services"}",
                    size: 20,
                    weight: FontWeight.bold,
                    color: aries ? SColors.aries : libra ? SColors.libra : aqua ? SColors.aqua : SColors.virgo
                  ),
                  const SizedBox(height: 20),
                ]
              )
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverAnimatedList(
              itemBuilder: (context, index, animation) {
                int newIndex() {
                  if(index.isEqual(0)) return 1;
                  if(index.isEqual(1)) return 2;
                  if(index.isEqual(2)) return 3;
                  return 4;
                }
                return SText(
                  text: "${newIndex()}: ${services[index].service}",
                  size: 16,
                  weight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight
                );
              },
              initialItemCount: services.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  if(aries || libra || aqua)
                  SButton(
                    text: changeService ? "Stop edit" : "Change service",
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    textWeight: FontWeight.bold,
                    textSize: 18,
                    onClick: canChangeService ? () {
                      setState(() => changeService = !changeService);
                    } : null,
                  ),
                  const SizedBox(height: 30),
                  if(changeService)
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        aqua ? NewAqua(model: services)
                        : libra ? Libra(selectedService: selectedService)
                        : aries ? Aries(selected: selected) : const Virgo(),
                        const SizedBox(height: 20),
                        SButton(
                          text: "Save changes",
                          width: Get.width,
                          padding: const EdgeInsets.all(10),
                          textWeight: FontWeight.bold,
                          textSize: 18,
                          onClick: () => Get.to(() => const SubscribeSelectScreen()),
                        ),
                        const SizedBox(height: 20),
                      ]
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const SText(
                      text: "NOTE: At the end of each subscription timeline, a button will appear below to enable you change your plan, if you feel like.",
                      color: SColors.hint,
                      weight: FontWeight.bold,
                      size: 12
                    )
                  ),
                  const SizedBox(height: 20),
                  if(canChange)
                  SButton(
                    text: "Feel like changing your plan? Click me",
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    textWeight: FontWeight.bold,
                    textSize: 18,
                    onClick: () => Get.to(() => const SubscribeSelectScreen()),
                  ),
                ],
              )
            )
          ),
        ],
      )
    );
  }
}