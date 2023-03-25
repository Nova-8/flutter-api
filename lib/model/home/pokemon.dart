import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  Pokemon({
    this.count = 0,
    this.next = '',
    this.previous,
    this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result>? results;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.name = '',
    this.url = '',
  });

  String name;
  String url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"].toString().toUpperCase(),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
