import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

void customSnackBar(BuildContext context,
    [String? message, Color? color, int? seconds]) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    width: context.width/3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      duration: Duration(seconds: seconds ?? 2),
      backgroundColor: (color ?? ColorManager.brown).withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          message ?? "there was an error please try again later!",
          style:
              context.textTheme.bodySmall?.copyWith(color: ColorManager.white),
        ),
      )));
}
