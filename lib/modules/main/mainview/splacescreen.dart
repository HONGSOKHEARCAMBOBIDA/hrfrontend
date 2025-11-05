import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/modules/auth/view/loginview.dart';
import 'package:flutter_application_10/modules/main/mainview/mainview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read("token");

    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/Lottie/Animation - 1739864772865.json",
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 50),
          const Text(
            "Welcome",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      nextScreen: (token == null || token.toString().isEmpty)
          ? const LoginView()
          : const MainView(),
      splashIconSize: 400,
      duration: 3000,
      backgroundColor: Colors.white,
    );
  }
}
