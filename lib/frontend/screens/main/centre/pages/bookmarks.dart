import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<BookmarkModel> bookmarkList = [
    BookmarkModel(service: "Electrician", name: "Evaristus Adimonyemma", id: "Frank", rate: 0, ),
    BookmarkModel(service: "Plumber", name: "Odira Adimonyemma", id: "Cherry", rate: 1, ),
    BookmarkModel(service: "Barber", name: "Chisom Adimonyemma", id: "Dublin", rate: 2, ),
    BookmarkModel(service: "Mechanic", name: "Chidimma Adimonyemma", id: "Undoies", rate: 3.5, ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SText.center(
          text: "Bookmarks",
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
        actions: [
          IconButton(
            onPressed: () {
              final snackBar = SnackBar(content: Text(
                'Slide a provider tab to remove the provider from your bookmark list.',
                style: TextStyle(color: Theme.of(context).primaryColor)
              ), backgroundColor: Theme.of(context).backgroundColor,);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: const Icon(Icons.info, color: SColors.hint)
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: screenPadding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  final bookmark = bookmarkList[index];
                  return Dismissible(
                    key: Key(bookmark.id),
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      setState(() {
                        bookmarkList.removeAt(index);
                      });

                      // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You have unbookmarked ${bookmark.name}',
                            style: TextStyle(color: Theme.of(context).primaryColor)
                          ),
                          backgroundColor: Theme.of(context).backgroundColor,
                        )
                      );
                    },
                    // Show a red background as the item is swiped away.
                    background: Container(color: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Material(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          onTap: () {
                            showProviderProfile(context: context, model: bookmark);
                            debugShow(bookmark.rate.toInt());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Picture.medium(),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SText(text: bookmark.name, color: Theme.of(context).primaryColorLight, size: 16),
                                          RatingBarIndicator(
                                            rating: bookmark.rate,
                                            itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                                            itemCount: 5,
                                            itemSize: 15.0,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      SText(text: bookmark.service, color: SColors.hint, size: 16)
                                    ],
                                  ),
                                ),
                              ],
                            )
                          )
                        ),
                      ),
                    ),
                  );
                }),
                childCount: bookmarkList.length,
              ),
            ),
          ),
        ],
      )
    );
  }
}