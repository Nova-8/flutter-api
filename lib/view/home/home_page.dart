import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapi/controller/home/home_controller.dart';
import 'package:pokemonapi/model/colors.dart';
import 'package:pokemonapi/model/end_point.dart';
import 'package:pokemonapi/model/home/pokemon.dart';
import 'package:pokemonapi/model/home/pokemon_selected.dart';
import 'package:pokemonapi/view/ui/loading_progress.dart';
import 'package:skeletons/skeletons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Intercambio pokemon'),
            actions: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: Get.context!,
                    builder: (BuildContext bc) {
                      if (_.pokemonsSelects.isNotEmpty) {
                        List<Widget> list = [];
                        for (var element in _.pokemonsSelects) {
                          list.add(_buildCardsSelected(element, _));
                        }
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: list,
                          ),
                        );
                      }
                      return const SizedBox(
                        height: double.infinity,
                        child: Center(
                          child: Text('Aún no tienes un equipo'),
                        ),
                      );
                    },
                  );
                },
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/loading_pokedex_2.png',
                      width: 40,
                    ),
                    Positioned(
                      bottom: 12,
                      child: Text(
                        _.pokemonsSelects.length.toString(),
                        style: Theme.of(Get.context!)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Skeleton(
              skeleton: SkeletonListView(),
              isLoading: _.loading,
              child: ListView.builder(
                itemCount: _.pokemons!.length + 1,
                controller: _.scrollController,
                itemBuilder: (context, index) {
                  if (index == _.pokemons!.length) {
                    if (_.loadingList) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: PACircularProgress(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    Result pokemon = _.pokemons![index]!;
                    return _buildCards(index + 1, pokemon, _);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCards(int index, Result pokemon, HomeController _) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        heightFactor: 2,
                        child: Image.asset(
                          'assets/images/loading_pokedex_5.png',
                          color: PAColors.blue,
                          width: 70,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nombre:  ${pokemon.name}',
                        style: Theme.of(Get.context!).textTheme.bodyText1,
                      ),
                      Text(
                        'Tipo: ',
                        style: Theme.of(Get.context!).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: const Text('data'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: const Text('data'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: _.pokemonsSelects.length <= 4
                  ? _.pokemonsSelects.any((element) => element.index == index)
                      ? Center(
                          child: Text(
                            'Este pokemon ya esta en tu equipo',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  color: Colors.redAccent,
                                ),
                          ),
                        )
                      : MaterialButton(
                          color: Colors.redAccent,
                          onPressed: () => _.addToListPokemons(pokemon, index),
                          child: Text(
                            'Agregar a mi equipo',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        )
                  : Center(
                      child: Text(
                        'Tu equipo está completo',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                              color: Colors.redAccent,
                            ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsSelected(PokemonSelected pokemons, HomeController _) {
    return Card(
      elevation: 5,
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  '${EndPoint().baseURlImagePng}${pokemons.index}.png',
                  height: 100,
                  fit: BoxFit.scaleDown,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Swing(
                      infinite: true,
                      child: Center(
                        heightFactor: 2,
                        child: Image.asset(
                          'assets/images/loading_pokedex_5.png',
                          color: PAColors.blue,
                          width: 70,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemons.pokemon.name,
                        style: Theme.of(Get.context!).textTheme.bodyText1,
                      ),
                      MaterialButton(
                        color: Colors.redAccent,
                        onPressed: () => _.deleteToListPokemons(pokemons),
                        child: Text(
                          'Eliminar de mi equipo',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
