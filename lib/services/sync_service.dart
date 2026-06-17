import 'character_api_service.dart';
import 'character_local_database.dart';
import 'spell_api_service.dart';
import 'spell_local_database.dart';

class SyncService {
  static Future<void> loadCharactersIfNeeded() async {
    if (!CharacterLocalDatabase.isEmpty()) {
      return;
    }
    final characters = await CharacterApiService.fetchCharacters();
    await CharacterLocalDatabase.saveCharacters(characters);
  }

  static Future<void> loadSpellsIfNeeded() async {
    if (!SpellLocalDatabase.isEmpty()) {
      return;
    }
    final spells = await SpellApiService.fetchSpells();
    await SpellLocalDatabase.saveSpells(spells);
  }
}
