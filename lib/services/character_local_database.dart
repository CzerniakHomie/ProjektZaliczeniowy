import 'package:hive_ce/hive.dart';
import '../models/character.dart';

class CharacterLocalDatabase {
  static Box get _box => Hive.box("characters");

  static List<Character> getCharacters() {
    return _box.values.map((item) {
      return Character.fromMap(Map<String, dynamic>.from(item));
    }).toList();
  }

  static Future<void> saveCharacters(List<Character> characters) async {
    await _box.clear();
    for (final character in characters) {
      await _box.put(character.id, character.toMap());
    }
  }

  static bool isEmpty() {
    return _box.isEmpty;
  }
}
