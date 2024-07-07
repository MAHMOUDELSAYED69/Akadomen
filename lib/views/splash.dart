import 'package:akadomen/utils/constants/images.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ImageManager.background),
          ),
        ),
      ),
    );
  }
}
