import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/lib.dart';

class ProviderProfile extends StatefulWidget {
  final BookmarkModel model;
  const ProviderProfile({super.key, required this.model});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  List<RatingTalkModel> ratingList = [
    RatingTalkModel(image: SImages.barberAvatar, name: "Evaristus Adimonyemma", rate: 4, good: true)
  ];
  bool offline = false;
  String distance = "5km";
  double tripCount = 2;
  bool online = false;
  final padded = const EdgeInsets.only(bottom: 12);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padded,
          sliver: SliverToBoxAdapter(
            child: Container(
              color: SColors.hint,
              height: 2,
              width: 100,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const Picture(radius: 70),
              const SizedBox(height: 10),
              RatingBarIndicator(
                rating: 3,
                itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 15.0,
              ),
              const SizedBox(height: 10),
              SText.center(
                text: widget.model.name,
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
            ],
          )
        ),
        SliverToBoxAdapter(
          child: Column(
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
                    online ? CupertinoIcons.bolt_circle_fill : offline ? CupertinoIcons.bolt_slash_fill
                      : CupertinoIcons.bolt_horizontal_circle_fill,
                    color: online ? SColors.green : offline ? SColors.red : SColors.yellow,
                    size: 16
                  ),
                  SText(
                    text: online ? " Online" : offline ? " Offline" : " Busy but Online",
                    size: 16, weight: FontWeight.bold,
                    color: online ? SColors.green : offline ? SColors.red : SColors.yellow,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  SText(
                    text: "Distance: ",
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                  SText(
                    text: distance,
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  SText(
                    text: "Service Trip Count: ",
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                  SText(
                    text: tripCount.toString(),
                    size: 16, weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: const [
              SizedBox(height: 20),
              SText(
                text: "Recent Rating Comments",
                size: 16, weight: FontWeight.bold,
                color: SColors.hint
              ),
              SizedBox(height: 10),
            ],
          )
        ),
        if(ratingList.isEmpty)
        const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 200),
          sliver: SliverToBoxAdapter(child: SText.center(text: "You have no rating", color: SColors.hint, size: 24)),
        )
        else
        SliverList(
          delegate: SliverChildBuilderDelegate(((context, index) {
            return RatingTalks(model: ratingList[index], backgroundColor: Theme.of(context).scaffoldBackgroundColor,);
          }), childCount: ratingList.length)
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20))
      ],
    );
  }
}