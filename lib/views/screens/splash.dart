import 'package:akadomen/utils/constants/aduios.dart';
import 'package:akadomen/utils/constants/images.dart';
import 'package:akadomen/utils/constants/routes.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _audioPlayer();
    _goToNextScreen();
  }

  late AudioPlayer _player;
  Future<void> _audioPlayer() async {
    _player.play(
      volume: double.infinity,
      UrlSource(AudiosManager.akadomenAduio),
    );
  }

  Future<void> _goToNextScreen() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        return Navigator.pushReplacementNamed(context, RouteManager.login);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ImageManager.background),
          ),
        ),
        child: Image.asset(
          ImageManager.akadomenLogo,
          width: context.width / 3,
          height: context.width / 3,
          color: Colors.white,
        ),
      ),
    );
  }
}
