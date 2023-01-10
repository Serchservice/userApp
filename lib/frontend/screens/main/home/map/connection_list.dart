import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';

class OnlineProviderList extends StatefulWidget{
  final String title;
  final String location;
  const OnlineProviderList({super.key, required this.title, required this.location,});

  @override
  State<OnlineProviderList> createState() => _OnlineProviderListState();
}

class _OnlineProviderListState extends State<OnlineProviderList> {
  bool pressed = true;

  void closeSearch() {
    // widget.serviceRequestRef.delete();
    Get.back();
  }

  Future <bool> closeOnPop() {
    if(pressed){
      closeSearch();
      return Future.value(true);
    } else {
      return Future.value(false);
    }
    // if (isDoublePress) {
    //   return Future.value(true);
    // } else {
    //   Get.snackbar('Warning!', 'Press again to exit');
    //   isDoublePress = true;
    //   Timer(const Duration(seconds: 3), () => isDoublePress = false);
    //   return Future.value(false);
    // }
  }

  List<ConnectionModel> connectionList = [
    ConnectionModel(distance: "4km", name: "Frank Edward", rate: 3.4, status: true, id: "jdhgdudggtfufhdd"),
    ConnectionModel(distance: "4km", name: "Cjesu Edward", rate: 1.4, status: false, id: "jidvoavhdeubeavsdsa"),
    ConnectionModel(distance: "4km", name: "Jess Edward", rate: 0, status: false, id: "jsuiapaofbeovbp"),
    ConnectionModel(distance: "4km", name: "Frank Cobbler", rate: 3.9, status: true, id: "pkasvoabsvoavnp")
  ];

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () => closeOnPop(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0.5,
          centerTitle: true,
          title: SText.center(
            text: "Serch ${widget.title} List",
            size: 20,
            weight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight
          ),
          leading: IconButton(
            onPressed: () => closeSearch(),
            icon: Icon(
              CupertinoIcons.chevron_back,
              color: Theme.of(context).primaryColorLight,
              size: 28
            )
          ),
          actions: [
            PopupMenuButton<MapFilter>(
              onSelected: (value) {
                // if(value == PopupMenus.signOut){
                //   WLAuth().signOut();
                // }
                if(value == MapFilter.rate){
                  // connectionList.map((e) => e.rate.compareTo(e.rate),);
                  // debugShow(connectionList);
                } else if(value == MapFilter.distance){

                } else {

                }
              },
              elevation: 0,
              color: Theme.of(context).backgroundColor,
              icon: const Icon(Icons.filter_alt_outlined, color: SColors.hint,),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: MapFilter.rate,
                  child: SText(text: "By Rating", color: Theme.of(context).primaryColor, weight: FontWeight.bold)
                ),
                PopupMenuItem(
                  value: MapFilter.distance,
                  child: SText(text: "By Distance", color: Theme.of(context).primaryColor, weight: FontWeight.bold)
                ),
                PopupMenuItem(
                  value: MapFilter.verified,
                  child: SText(text: "By Status", color: Theme.of(context).primaryColor, weight: FontWeight.bold)
                )
              ]
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: SColors.yellow,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SText(
                        text: "My Location:",
                        color: SColors.white,
                        size: 16,
                        weight: FontWeight.bold
                      ),
                      SText(
                        text: widget.location,
                        color: SColors.white,
                        size: 16,
                        weight: FontWeight.bold
                      ),
                    ],
                  )
                ),
              ),
    
              const SizedBox(height: 10),
    
              Expanded(
                child: ListView.builder(
                  itemBuilder:(context, index) {
                    return ConnectionWidget(
                      model: connectionList[index],
                      onChat: () {} ,
                      onProfile: () {} ,
                      onVideo: () {} ,
                      onVoice: () {} ,
                    );
                  },
                  itemCount: connectionList.length,
                )
              )
            ]
          ),
        )
      ),
    );
  }
}