import 'package:get/get.dart';
import 'package:pokemonapi/view/splash/splash_page.dart';

final routes = [
  GetPage(
    name: '/',
    page: () => const SplashPage(),
    transition: Transition.circularReveal,
  ),
];
