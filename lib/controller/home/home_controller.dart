import 'package:get/get.dart';
import 'package:pokemonapi/model/home/pokemon.dart';
import 'package:pokemonapi/model/network/network.dart';

class HomeController extends GetxController {
  Pokemon? _pokemon;
  final List<Result> _pokemons = [];
  bool _loading = false;

  Pokemon? get pokemon => _pokemon;
  List<Result> get pokemons => _pokemons;
  bool get loading => _loading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getPokemons();
  }

  void _getPokemons() async {
    _loading = true;
    update(['ListPokemons']);
    Map<String, String> params = {'limit': '20', 'offset': '20'};

    final network = Network();
    var a = await network.getListaPokemons(params: params);
    _pokemon = a;
    if (_pokemon != null) {}
    _loading = false;
    update(['ListPokemons']);
  }
}
