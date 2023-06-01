import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_project/utils/colors.dart';

class AppButton extends StatelessWidget {
  Function()? onPressed;
  String title;
  bool isDisabled = false;

  AppButton(
      {required this.isDisabled, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: isDisabled
          ? Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ).center().withSize(
                width: context.width() - 32,
                height: 48,
              )
          : Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [kPrimaryColor, kPrimaryColorLight]),
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: context.width() - 32,
                height: 48,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
    );
  }
}
