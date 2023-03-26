import 'package:get/get.dart';
import 'package:pokemonapi/model/home/pokemon.dart';
import 'package:pokemonapi/model/network/network.dart';

class HomeController extends GetxController {
  Pokemon? _pokemon;
  List<Result>? _pokemons = [];
  bool _loading = false;
  int limit = 20;
  int offset = 0;

  Pokemon? get pokemon => _pokemon;
  List<Result?>? get pokemons => _pokemons;
  bool get loading => _loading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getPokemons();
  }

  void _getPokemons() async {
    _loading = true;
    update();
    Map<String, String> params = {
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    final network = Network();
    _pokemon = await network.getListaPokemons(params: params);
    if (_pokemon != null) {
      if (_pokemon!.results! != null) {
        this._pokemons = pokemon!.results!;
      }
    }
    _loading = false;
    update();
  }
}
