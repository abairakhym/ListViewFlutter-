import 'dart:convert';

import 'package:http/http.dart' as http;

class CharacterList {
  List<Character> characters;
  CharacterList({required this.characters});

  factory CharacterList.fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'] as List;

    List<Character> characterList =
        resultsJson.map((i) => Character.fromJson(i)).toList();

    return CharacterList(characters: characterList);
  }
}

class Character {
  String name;
  String gender;
  String image;

  Character({
    required this.name,
    required this.gender,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        name: json['name'], gender: json['gender'], image: json['image']);
  }
}

Future<CharacterList> getCharacterList() async {
  var url = 'https://rickandmortyapi.com/api/character';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return CharacterList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response}');
  }
}
