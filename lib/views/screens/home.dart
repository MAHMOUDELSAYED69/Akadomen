import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}
