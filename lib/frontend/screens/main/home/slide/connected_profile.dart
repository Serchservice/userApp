import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/lib.dart';

class ConnectedProfile extends StatefulWidget {
  final String serviceStatus;
  final String condition;
  final String name;
  final bool hasBusyButOnline;
  final VoidCallback? cancelClick;
  final VoidCallback? endClick;
  const ConnectedProfile({
    super.key, required this.serviceStatus, this.hasBusyButOnline = true, required this.condition,
    required this.name, this.cancelClick, this.endClick
  });

  @override
  State<ConnectedProfile> createState() => _ConnectedProfileState();
}

class _ConnectedProfileState extends State<ConnectedProfile> {
  bool hasRequestShare = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Picture(radius: 70),
        const SizedBox(height: 10),
        RatingBarIndicator(
          rating: 3,
          itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 15.0,
        ),
        const SizedBox(height: 5),
        SText.center(
          text: widget.name,
          size: 20, weight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SIcon(
                    icon: CupertinoIcons.phone_fill,
                    iconColor: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ),
            Material(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SIcon(
                    icon: CupertinoIcons.video_camera_solid,
                    iconColor: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ),
            Material(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SIcon(
                    icon: CupertinoIcons.bubble_left_bubble_right_fill,
                    iconColor: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SText(
                  text: "Status: ",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight
                ),
                Icon(
                  widget.hasBusyButOnline ? CupertinoIcons.bolt_horizontal_circle_fill : CupertinoIcons.bolt_slash_fill,
                  color: widget.hasBusyButOnline ? SColors.green : SColors.yellow,
                  size: 16
                ),
                SText(
                  text: widget.hasBusyButOnline ? " Busy but online" : " Busy",
                  size: 16, weight: FontWeight.bold,
                  color: widget.hasBusyButOnline ? SColors.green : SColors.yellow,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                SText(
                  text: "Service Status: ",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight
                ),
                SText(
                  text: widget.serviceStatus,
                  size: 16, weight: FontWeight.bold,
                  color: widget.serviceStatus == "Ongoing" ? SColors.green : SColors.yellow,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                SText(
                  text: "Condition: ",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight
                ),
                SText(
                  text: widget.condition,
                  size: 16, weight: FontWeight.bold,
                  color: widget.condition == "Arrived" ? SColors.green : SColors.red,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            SButton(
              textSize: 16,
              text: "Cancel Service",
              padding: const EdgeInsets.all(10),
              textWeight: FontWeight.bold,
              onClick: widget.cancelClick,
            ),
            const SizedBox(height: 10),
            SButton(
              textSize: 16,
              text: "End Service",
              padding: const EdgeInsets.all(10),
              textWeight: FontWeight.bold,
              onClick: widget.endClick
            ),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}