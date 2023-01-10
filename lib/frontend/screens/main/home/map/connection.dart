import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/lib.dart';

class ConnectionWidget extends StatelessWidget {
  final ConnectionModel model;
  final VoidCallback? onChat;
  final VoidCallback? onVideo;
  final VoidCallback? onVoice;
  final VoidCallback? onProfile;
  const ConnectionWidget({super.key, required this.model, this.onChat, this.onVideo, this.onVoice, this.onProfile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Picture.medium(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: SText(text: model.name, color: Theme.of(context).primaryColorLight, size: 16)),
                      RatingBarIndicator(
                        rating: model.rate,
                        itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 15.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SText(text: "${model.distance} away", color: SColors.hint, size: 16),
                      SText(
                        text: model.status ? "Online" : "Busy but Online",
                        color: model.status ? SColors.green : SColors.yellow, size: 16
                      ),
                    ]
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 5.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: onVoice,
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: onVideo,
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: onChat,
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: onProfile,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SIcon(
                              icon: CupertinoIcons.profile_circled,
                              iconColor: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}