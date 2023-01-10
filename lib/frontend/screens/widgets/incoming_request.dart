import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:user/lib.dart';
// import 'package:http/http.dart' as http;

void confirmIncomingUserCTGRequest({required BuildContext context, required String client,}){
  final formKey = GlobalKey<FormState>();
  final input = FocusNode();
  final addressName = TextEditingController();

  showDialog(
    context: context,
    builder:(context) => StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          CupertinoIcons.chevron_back,
                          color: Theme.of(context).primaryColor,
                          size: 28
                        )
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SText(
                      text: "Confirm that you are ready to Connect-To-Go",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: SColors.blue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: SText(text: client, color: SColors.white, size: 16, weight: FontWeight.bold,)
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stepping(lineH: 6,),
                    Stepping(lineH: 6,)
                  ],
                ),
                SFormField(
                  focus: input,
                  labelText: "Enter your location",
                  formName: "What is the location of the $client?",
                  controller: addressName,
                  validate: (value) {
                    if(value!.isEmpty){
                      return "You must enter a service location";
                    } else {
                      return null;
                    }
                  },
                  formColor: Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  enabledBorderColor: Theme.of(context).primaryColorDark,
                  prefixIcon: const Icon(CupertinoIcons.location_fill, color: SColors.red),
                  formStyle: STexts.normalForm(context),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stepping(lineH: 6,),
                    Stepping(lineH: 6,)
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Theme.of(context).backgroundColor,
                    child: InkWell(
                      onTap: () => {},
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.mapLocation,
                              size: 16,
                              color: Theme.of(context).primaryColor
                            ),
                            const SizedBox(width: 20),
                            SText(
                              text: "Use my current location",
                              color: Theme.of(context).primaryColor,
                              size: 16,
                              weight: FontWeight.bold
                            )
                          ]
                        ),
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SButton(
                  text: "Search",
                  textSize: 16,
                  textWeight: FontWeight.bold,
                  onClick: () => {}
                ),
              ],
            ),
          ),
        ),
      )
    ),
  );
}





void confirmIncomingProviderShareRequest({required BuildContext context, required String providerName}){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      bool hasRequestShare = false;
      bool stickWithMe = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            elevation: 0,
            title: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                const Picture.small(),
                SText(
                  text: "$providerName is trying to share a job with you, do you accept?",
                  color: Theme.of(context).primaryColor, size: 18
                ),
              ],
            ),
            content: UserPreferences().getSWM() ? null : CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              checkColor: SColors.white,
              activeColor: SColors.lightPurple,
              title: SText(
                text: "Enable Stick-With-Me",
                color: Theme.of(context).primaryColor, size: 14
              ),
              value: stickWithMe,
              onChanged: (val) {
                setState(() => stickWithMe = !stickWithMe);
              }
            ),
            actions: [
              SBtn(
                text: "Yes, I do", textSize: 16,
                buttonColor: Theme.of(context).bottomAppBarColor,
                textColor: SColors.lightPurple,
                onClick: () {
                  setState(() => hasRequestShare = true);
                  UserConnection().saveHasRequestShare(hasRequestShare);
                  UserPreferences().saveSWM(stickWithMe);
                  Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 0)), (route) => false);
                }
              ),
              SBtn(
                text: "No, I don't", textSize: 16,
                onClick: () => Navigator.of(context).pop(false),
                buttonColor: Theme.of(context).bottomAppBarColor,
                textColor: SColors.lightPurple,
              )
            ],
          );
        }
      );
    }
  );
}