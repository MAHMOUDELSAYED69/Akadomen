import 'package:akadomen/utils/constants/routes.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:akadomen/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: context.width,
            height: context.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageManager.homeBackground),
              ),
            ),
          ),
          Row(
            children: [
            SizedBox(width: context.width/8.7),
              MyElevatedButton(
                backgroundColor: ColorManager.white.withOpacity(0.7),
                size: Size(context.width / 2, context.height / 2),
                widget:  Icon(
                  Icons.add_a_photo_rounded,
                   size: 20.sp,
                   color: ColorManager.brown,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Positioned(
            left: 5,
            top: 5,
            child: IconButton(
                hoverColor: ColorManager.white,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ColorManager.white.withOpacity(0.7),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  size: 7.sp,
                  Icons.arrow_back,
                  color: ColorManager.brown,
                )),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: context.width / 30),
                    padding: const EdgeInsets.all(20),
                    width: context.width / 4.5,
                    height: context.height / 1.2,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, -1),
                          color: ColorManager.brown.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        MyElevatedButton(
                          title: 'Logout',
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteManager.login,
                              (route) => false,
                            );
                          },
                        )
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
