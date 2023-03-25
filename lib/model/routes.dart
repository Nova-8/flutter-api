import 'package:get/get.dart';
import 'package:get/route_manager.dart' as route;
import 'package:pokemonapi/view/home/home_page.dart';
import 'package:pokemonapi/view/splash/splash_page.dart';

final routes = [
  GetPage(
    name: '/',
    page: () => const SplashPage(),
    transition: Transition.circularReveal,
  ),
  GetPage(
    name: '/home',
    page: () => const HomePage(),
    transition: route.Transition.fadeIn,
    transitionDuration: const Duration(
      milliseconds: 1000,
    ),
  ),
];
