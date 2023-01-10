import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:user/lib.dart';

class ActivateFreeTrialScreen extends StatelessWidget {
  const ActivateFreeTrialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor
          )
        ),
        elevation: 0,
        centerTitle: true,
        title: SText.theme(
          text: "Activating Free Trial",
          size: 18,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColor
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Column(
              children: [
                Lottie.network(
                  "https://assets10.lottiefiles.com/private_files/lf30_zn0soefi.json",
                  height: 150
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: SColors.yellow,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Wrap(
                    children: const [
                      SText(
                        text: "Before you start your free trial, there are points you need to know.",
                        size: 16,
                      ),
                      SText(
                        text: "1. Serch grants you 14 days to make use of all its services during this trial period.",
                        size: 16,
                      ),
                      SText(
                        text: "2. We encourage our users to maximize this full opportunity to get to know us, as we do you.",
                        size: 16,
                      ),
                      SText(
                        text: "3. Towards the end of the trial period, Serch will automatically remind you through email, about the need to Sbscribe.",
                        size: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SButton(
                  text: "Enjoy",
                  width: width,
                  textWeight: FontWeight.bold,
                  textSize: 18,
                  onClick: () => Get.offAll(() => const FreeTrialActivateConfirmScreen())
                ),
              ],
            )
          )
        )
      ),
    );
  }
}