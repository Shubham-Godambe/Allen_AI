import 'package:allen/pallete.dart';
import 'package:flutter/material.dart';

Image logoWidget(String imagename) {
  return Image.asset(
    imagename,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Pallete.assistantCircleColor,
  );
}

Stack image(double Height, double weight) {
  return Stack(
    children: [
      Center(
        child: Container(
          height: Height,
          width: weight,
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              color: Pallete.assistantCircleColor, shape: BoxShape.circle),
        ),
      ),
      Container(
        height: Height + 5,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage("assets/images/virtualAssistant.png"))),
      ),
    ],
  );
}
