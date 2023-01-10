import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/lib.dart';

class CHHButtons extends StatelessWidget {
  final VoidCallback? voiceClick;
  final VoidCallback? videoClick;
  final VoidCallback? messageClick;
  final VoidCallback? psClick;
  const CHHButtons({
    super.key, this.voiceClick, this.videoClick, this.messageClick, this.psClick
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        Material(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: voiceClick,
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
            onTap: videoClick,
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
            onTap: messageClick,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SIcon(
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                iconColor: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
        Material(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: psClick,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SIcon(
                    icon: Icons.amp_stories,
                    iconColor: Theme.of(context).primaryColorLight,
                  ),
                  const SizedBox(height: 5),
                  SText(text: "ProvideShare", color: Theme.of(context).primaryColorLight, size: 16, weight: FontWeight.bold)
                ]
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CHH extends StatelessWidget {
  final bool good;
  final bool bad;
  final String name;
  final String category;
  final double rate;
  const CHH({
    super.key, this.good = false, this.bad = false, this.name = "Evaristus Adimonyemma", this.category = "Electrician",
    this.rate = 4.5
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Picture(radius: 60,)),
        const SizedBox(height: 15),
        SText.center(text: name, color: Theme.of(context).primaryColorLight, size: 20, weight: FontWeight.bold,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SText.center(
              text: rate.toString(),
              color: rate >= 3.5 ? SColors.green : rate >= 1.5 ? SColors.yellow : SColors.red, size: 16,
              weight: FontWeight.bold,
            ),
            const SizedBox(width: 10),
            RatingBarIndicator(
              rating: rate,
              itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 15.0,
            ),
          ],
        ),
      ],
    );
  }
}