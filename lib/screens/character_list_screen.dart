import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/sync_service.dart';
import '../services/character_local_database.dart';
import 'character_detail_screen.dart';
import 'spell_list_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<Character>> charactersFuture;

  @override
  void initState() {
    super.initState();
    charactersFuture = loadCharacters();
  }

  Future<List<Character>> loadCharacters() async {
    await SyncService.loadCharactersIfNeeded();
    return CharacterLocalDatabase.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wizarding World'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_fix_high),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SpellListScreen(),
                ),
              );
            },
            tooltip: 'Zaklęcia',
          ),
        ],
      ),
      body: FutureBuilder<List<Character>>(
        future: charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Błąd: ${snapshot.error}'),
            );
          }
          final characters = snapshot.data ?? [];
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return CharacterCard(
                character: character,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterDetailScreen(
                        character: character,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Widget karty postaci
class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: character.image.isNotEmpty
              ? NetworkImage(character.image)
              : null,
          child: character.image.isEmpty ? const Icon(Icons.person) : null,
        ),
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${character.house.isNotEmpty ? character.house : "Brak domu"} • ${character.species}',
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
