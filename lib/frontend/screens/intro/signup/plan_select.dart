import 'package:flutter/material.dart';
import 'package:user/lib.dart';

class SelectPlanScreen extends StatelessWidget {
  const SelectPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SRes.isPhone(context)
      ? const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: SelectPlanForm()
          )
        )
      )
      : Column()
    );
  }
}