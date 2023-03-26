import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapi/controller/home/home_controller.dart';
import 'package:pokemonapi/model/colors.dart';
import 'package:pokemonapi/model/end_point.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Intercambio pokemon'),
            actions: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/loading_pokedex_2.png',
                  width: 40,
                ),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: _.pokemons!.length,
            itemBuilder: (context, index) {
              return _buildCards(index + 1);
            },
          ),
        );
      },
    );
  }

  Widget _buildCards(int index) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                '${EndPoint().baseURlImagePng}$index.png',
                height: 100,
                fit: BoxFit.scaleDown,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Swing(
                    infinite: true,
                    child: Center(
                      heightFactor: 3,
                      child: Image.asset(
                        'assets/images/loading_pokedex_5.png',
                        color: PAColors.blue,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text('Agregar a mi equipo'),
          ),
        ],
      ),
    );
  }
}
