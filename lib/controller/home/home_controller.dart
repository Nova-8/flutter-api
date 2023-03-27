import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapi/model/home/pokemon.dart';
import 'package:pokemonapi/model/home/pokemon_list.dart';
import 'package:pokemonapi/model/home/pokemon_selected.dart';
import 'package:pokemonapi/model/network/network.dart';

class HomeController extends GetxController {
  Pokemon? _pokemon;
  List<PokemonList> _pokemons = [];
  final List<PokemonSelected> _pokemonsSelects = [];
  bool _loading = false;
  bool _loadingList = false;
  final ScrollController _scrollController = ScrollController();
  int limit = 20;
  int offset = 0;
  final int _pokemonSelects = 0;

  Pokemon? get pokemon => _pokemon;
  List<PokemonList> get pokemons => _pokemons;
  List<PokemonSelected> get pokemonsSelects => _pokemonsSelects;
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
      List<PokemonList> list = [];
      for (var element in _pokemon!.results!) {
        list.add(PokemonList(pokemon: element));
      }
      if (append == true) {
        _pokemons.addAll(list);
      } else {
        _pokemons = list;
      }
      for (int i = _pokemons.length - 19; i <= _pokemons.length; i++) {
        _getDetailsPokemon(i);
      }
    }
    _loading = false;
    _loadingList = false;
    update();
  }

  void _getDetailsPokemon(int id) async {
    final network = Network();
    var pokemonDetail = await network.getDetailPokemons(id.toString());
    if (pokemonDetail != null) {
      _pokemons[id - 1].detail = pokemonDetail;
    }
    update();
  }

  void addToListPokemons(Result pokemon, int index) {
    _pokemonsSelects.add(
      PokemonSelected(
        pokemon: pokemon,
        index: index,
      ),
    );
    update();
  }

  void deleteToListPokemons(PokemonSelected value) {
    final index = _pokemonsSelects.indexOf(value);
    _pokemonsSelects.removeAt(index);
    update();
    Navigator.pop(Get.context!);
  }
}
