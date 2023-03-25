import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapi/controller/splash/splash_controller.dart';
import 'package:pokemonapi/model/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (getX) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PAColors.blue,
                    PAColors.yellow,
                  ],
                  stops: [0.1, 0.8],
                  tileMode: TileMode.clamp,
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo_pokedex.png'),
                    Image.asset('assets/images/loading_pokedex.png'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
