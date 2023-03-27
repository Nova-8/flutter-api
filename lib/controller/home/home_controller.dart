import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapi/model/home/pokemon.dart';
import 'package:pokemonapi/model/network/network.dart';

class HomeController extends GetxController {
  Pokemon? _pokemon;
  List<Result>? _pokemons = [];
  bool _loading = false;
  bool _loadingList = false;
  final ScrollController _scrollController = ScrollController();
  int limit = 20;
  int offset = 0;
  final int _pokemonSelects = 0;

  Pokemon? get pokemon => _pokemon;
  List<Result?>? get pokemons => _pokemons;
  bool get loading => _loading;
  bool get loadingList => _loadingList;
  int get pokemonSelect => _pokemonSelects;
  ScrollController get scrollController => _scrollController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getPokemons(false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!_loadingList) {
          _loadingList = true;
          offset = offset + 20;
          update();
          _getPokemons(true);
        }
      }
    });
  }

  void _getPokemons(bool append) async {
    if (!append) {
      _loading = true;
      update();
    }
    Map<String, String> params = {
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    final network = Network();
    _pokemon = await network.getListaPokemons(params: params);
    if (_pokemon != null) {
      if (append == true) {
        _pokemons!.addAll(pokemon!.results!);
      } else {
        _pokemons = pokemon!.results!;
      }
    }
    _loading = false;
    _loadingList = false;
    update();
  }
}
