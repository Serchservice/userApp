import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';
import 'package:provider/provider.dart';

class SlidePanel extends StatelessWidget {
  final bool onTrip;
  final VoidCallback? cancelClick;
  final VoidCallback? endClick;
  const SlidePanel({super.key, this.onTrip = false, this.cancelClick, this.endClick});

  @override
  Widget build(BuildContext context) {
    return onTrip ? OnTripWidget(
      cancelClick: cancelClick,
      endClick: endClick,
    ) : const NoTripWidget();
  }
}

class NoTripWidget extends StatefulWidget {
  const NoTripWidget({super.key});

  @override
  State<NoTripWidget> createState() => _NoTripWidgetState();
}

class _NoTripWidgetState extends State<NoTripWidget> {
  int selected = -1;
  bool one = false;
  bool two = false;
  bool three = false;
  String text1 = "Plumber";
  String text2 = "Mechanic";
  String text3 = "Electrician";
  String text4 = "Barber";

  void handleItemSelected(int index){
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      size: 22,
                      text: "${greeting()}${currentUserInfo?.firstName}",
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                    SText(
                      size: 16,
                      weight: FontWeight.w600,
                      text: "Where and what do you need help with?",
                      color: Theme.of(context).primaryColorLight
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: one ? SServiceContainer(
              onTap: handleItemSelected,
              index: 0,
              selected: (selected == 0),
              text: text1
            )
            : two ? Wrap(
              children: [
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 0,
                  selected: (selected == 0),
                  text: text1
                ),
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 1,
                  selected: (selected == 1),
                  text: text2
                )
              ],
            )
            : three ? Wrap(
              children: [
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 0,
                  selected: (selected == 0),
                  text: text1
                ),
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 1,
                  selected: (selected == 1),
                  text: text2
                ),
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 2,
                  selected: (selected == 2),
                  text: text3
                ),
              ],
            )
            : Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 0,
                  selected: (selected == 0),
                  text: text1
                ),
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 1,
                  selected: (selected == 1),
                  text: text2
                ),
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 2,
                  selected: (selected == 2),
                  text: text3
                ),
                SServiceContainer(
                  onTap: handleItemSelected,
                  index: 3,
                  selected: (selected == 3),
                  text: text4
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Stepping(lineH: 5),
              Stepping(lineH: 5)
            ],
          ),
          const SizedBox(height: 5),
          SText(
            text: "Your Current Address:",
            size: 16,
            weight: FontWeight.w600,
            color: Theme.of(context).primaryColorLight
          ),
          const SizedBox(height: 5),
          Material(
            color: SColors.virgo,
            borderRadius: BorderRadius.circular(3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.home, color: SColors.hint),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: SText(
                      text: Provider.of<UserMapInformation>(context).currentLocation != null
                      ? Provider.of<UserMapInformation>(context).currentLocation!.placeName!
                      : "Add Home",
                      size: 16,
                      color: SColors.white
                    ),
                  ),
                ]
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Stepping(lineH: 5),
              Stepping(lineH: 5)
            ],
          ),
          const SizedBox(height: 10),
          Material(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () => Get.to(() => SearchScreen(
                selected: selected == 0 ? text1 : selected == 1 ? text2 : selected == 2 ? text3 : text4,
              )),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.search, color: SColors.hint),
                    SizedBox(width: 10.0),
                    SText(text: "Enter your location", color: SColors.hint, weight: FontWeight.bold, size: 16)
                  ]
                )
              )
            ),
          ),
          const SizedBox(height: 70,)
        ],
      ),
    );
  }
}

class OnTripWidget extends StatelessWidget {
  final VoidCallback? cancelClick;
  final VoidCallback? endClick;
  const OnTripWidget({super.key, this.cancelClick, this.endClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SText(
              text: "View your ongoing service trip",
              size: 16,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            ConnectedProfile(
              serviceStatus: "Ongoing",
              condition: "On the way",
              name: "Evaristus Adimonyemma",
              endClick: endClick,
              cancelClick: cancelClick,
            )
          ]
        )
      ),
    );
  }
}