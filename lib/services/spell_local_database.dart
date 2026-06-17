import 'package:hive_ce/hive.dart';
import '../models/spell.dart';

class SpellLocalDatabase {
  static Box get _box => Hive.box("spells");

  static List<Spell> getSpells() {
    return _box.values.map((item) {
      return Spell.fromMap(Map<String, dynamic>.from(item));
    }).toList();
  }

  static Future<void> saveSpells(List<Spell> spells) async {
    await _box.clear();
    for (final spell in spells) {
      await _box.put(spell.id, spell.toMap());
    }
  }

  static bool isEmpty() {
    return _box.isEmpty;
  }
}
