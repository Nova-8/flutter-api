import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapi/model/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PokemonApi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFProMedium',
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.grey,
        ),
      ),
      initialRoute: '/',
      getPages: routes,
    );
  }
}
