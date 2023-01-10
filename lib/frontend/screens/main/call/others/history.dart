import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:user/lib.dart';

class CallHistoryScreen extends StatefulWidget {
  CallHistoryScreen({super.key});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> with WidgetsBindingObserver, TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: callHistoryCount, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void onNavigationItemSelected(index) {
    widget.pageIndex.value = index;
  }
  String psLink = "https://www.serchservice.com";
  bool generating = false;
  bool bookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
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
              setState(() => bookmarked = !bookmarked);
            },
            icon: Icon(
              bookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
              color: bookmarked ? SColors.green : Theme.of(context).primaryColorLight
            ),
          ),
          IconButton(
            onPressed: () => deleteUser(
              context: context,
              onClick: () {
                Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 2)), (route) => false);
              }
            ),
            icon: Icon(CupertinoIcons.delete, color: Theme.of(context).primaryColorLight),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const CHH(good: true,),
                  const SizedBox(height: 10),
                  CHHButtons(
                    voiceClick: () {},
                    videoClick: () {},
                    psClick: () async {
                      final snackBar = SnackBar(content: Text(
                        'Wait a moment, we are generating your PS share',
                        style: TextStyle(color: Theme.of(context).primaryColor)
                      ), backgroundColor: Theme.of(context).backgroundColor,);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      await Share.share(psLink);
                    },
                    messageClick: () {},
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                // borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
              child: Column(
                children: [
                  SCHTab(onItemSelected: onNavigationItemSelected,),
                ],
              )
            ),
          ),
          ValueListenableBuilder(
            valueListenable: widget.pageIndex,
            builder: (BuildContext context, int value, _) {
              return callHistory[value];
            },
          ),
        ],
      ),
    );
  }
}