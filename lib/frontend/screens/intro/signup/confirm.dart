import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user/lib.dart';

class FreeTrialActivateConfirmScreen extends StatefulWidget {
  const FreeTrialActivateConfirmScreen({super.key});

  @override
  State<FreeTrialActivateConfirmScreen> createState() => _FreeTrialActivateConfirmScreenState();
}

class _FreeTrialActivateConfirmScreenState extends State<FreeTrialActivateConfirmScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, callback);
  }

  callback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const BottomNavigator()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network("https://assets4.lottiefiles.com/packages/lf20_0oco6l9x.json"),
            const SText.center(
              text: "You have activated your free trial package",
              size: 20,
              weight: FontWeight.bold,
              color: SColors.green,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SText.center(
                text: "This page will automatically lead you to where you are going in seconds.",
                size: 16,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        )
      ),
    );
  }
}

class SignupConfirmScreen extends StatefulWidget {
  const SignupConfirmScreen({super.key});

  @override
  State<SignupConfirmScreen> createState() => _SignupConfirmScreenState();
}

class _SignupConfirmScreenState extends State<SignupConfirmScreen> {
  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 10);
    Timer(duration, () => Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const BottomNavigator()
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network("https://assets3.lottiefiles.com/packages/lf20_bskjzmma.json"),
            const SText(
              text: "Yay!",
              size: 32,
              weight: FontWeight.bold,
              color: SColors.green,
            ),
            const SizedBox(height: 10),
            const SText.center(
              text: "You have successfully created a Serch Account",
              size: 20,
              weight: FontWeight.bold,
              color: SColors.green,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SText.center(
                text: "This page will automatically lead you to where you are going in seconds.",
                size: 16,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        )
      ),
    );
  }
}