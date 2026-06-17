import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/spell.dart';

class SpellApiService {
  static const String baseUrl = 'https://hp-api.onrender.com';

  static Future<List<Spell>> fetchSpells() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/spells'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) {
        return Spell.fromMap(item);
      }).toList();
    } else {
      throw Exception('Błąd pobierania zaklęć');
    }
  }
}
