import 'package:akadomen/controllers/logout/logout_cubit.dart';
import 'package:akadomen/utils/constants/audios.dart';
import 'package:akadomen/utils/constants/images.dart';
import 'package:akadomen/utils/constants/routes.dart';
import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goToNextScreen();
    super.initState();
    _player = AudioPlayer();
    _audioPlayer();
  }

  late AudioPlayer _player;
  Future<void> _audioPlayer() async {
    _player.play(
      volume: double.infinity,
      UrlSource(AudiosManager.splashSound),
    );
  }

  Future<void> _goToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () => context.read<AuthStatus>().checkLoginStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatus, AuthStatusState>(
      listener: (context, state) {
        if (state is Login) {
          Navigator.pushReplacementNamed(context, RouteManager.home);
        }
        if (state is Logout) {
          Navigator.pushReplacementNamed(context, RouteManager.login);
        }
      },
      child: Scaffold(
        body: Container(
          width: context.width,
          height: context.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImageManager.authBackground),
            ),
          ),
          child: Image.asset(
            ImageManager.akadomenLogo,
            width: context.width / 3,
            height: context.width / 3,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
