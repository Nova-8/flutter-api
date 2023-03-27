import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapi/model/end_point.dart';
import 'package:pokemonapi/model/home/pokemon.dart';
import 'package:pokemonapi/model/home/pokemon_detail.dart';

class Network {
  Future<dynamic> getListaPokemons({
    Map<String, dynamic> params = const {},
  }) async {
    String content = '';
    Pokemon? objectResponse;

    content = (params.keys
            .map((key) => '$key=${Uri.encodeQueryComponent(params[key])}'))
        .join('&');

    try {
      debugPrint('-> ${EndPoint().baseUrlSearch}?$content');
      await http
          .get(
        Uri.parse('${EndPoint().baseUrlSearch}?$content'),
      )
          .then((response) {
        if (response.statusCode == 200) {
          objectResponse = Pokemon.fromJson(
            jsonDecode(
              response.body.replaceAll('\'', ''),
            ),
          );
        } else {
          objectResponse = null;
          debugPrint('Ha ocurrido un error:');
          debugPrint(response.statusCode.toString());
        }
      });
    } catch (e) {
      debugPrint('Ha ocurrido un error:');
      debugPrint(e.toString());
      return null;
    }
    return objectResponse;
  }

  Future<dynamic> getDetailPokemons(String id) async {
    PokemonDetail? objectResponse;
    try {
      var url = Uri.parse('${EndPoint().baseUrlSearch}/$id');
      debugPrint('Url -> $url');
      await http.get(url).then((response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          objectResponse = PokemonDetail.fromJson(
              jsonDecode(response.body.replaceAll('\'', '')));
        } else {
          objectResponse = null;
        }
      });
      return objectResponse;
    } catch (id) {
      debugPrint(id.toString());
      return null;
    }
  }
}
