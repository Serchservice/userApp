import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "package:user/lib.dart";

Icon getEmojiRate(int index){
  switch (index) {
    case 0:
      return const Icon(Icons.sentiment_very_dissatisfied, color: Colors.red);
    case 1:
      return const Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent);
    case 2:
      return const Icon(Icons.sentiment_neutral, color: Colors.amber);
    case 3:
      return const Icon(Icons.sentiment_satisfied, color: Colors.lightGreen);
    case 4:
      return const Icon(Icons.sentiment_very_satisfied, color: Colors.green);
    default:
      return const Icon(Icons.sentiment_very_satisfied, color: Colors.green);
  }
}

Widget getLoveRate({required int index, double size = 20}){
  return index == 0
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.hint, size: size),
      ]
    )
  : index < 1
  ? Row(
      children: [
        Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index == 1
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index < 2
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index == 2
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index < 3
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index == 3
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index < 4
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index == 4
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.hint, size: size),
      ]
    )
  : index < 5
  ? Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: size),
      ]
    )
  : Row(
      children: [
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
        const SizedBox(width: 2),
        Icon(CupertinoIcons.star_fill, color: SColors.rate, size: size),
      ]
    );
}