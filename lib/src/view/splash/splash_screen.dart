import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final splashontroller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    splashontroller.startSplashScreen();
    mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image(image:  AssetImage(splashImage),width: mediaQuery.width *  .8,
          height: mediaQuery.height * .8,),
      ),
    );
  }
}
