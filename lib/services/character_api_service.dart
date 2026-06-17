import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharacterApiService {
  static const String baseUrl = 'https://hp-api.onrender.com';

  static Future<List<Character>> fetchCharacters() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/characters'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) {
        return Character.fromMap(item);
      }).toList();
    } else {
      throw Exception('Błąd pobierania postaci');
    }
  }
}
