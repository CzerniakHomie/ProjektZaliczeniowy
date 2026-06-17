import 'package:flutter/material.dart';
import '../models/spell.dart';
import '../services/sync_service.dart';
import '../services/spell_local_database.dart';

class SpellListScreen extends StatefulWidget {
  const SpellListScreen({super.key});

  @override
  State<SpellListScreen> createState() => _SpellListScreenState();
}

class _SpellListScreenState extends State<SpellListScreen> {
  late Future<List<Spell>> spellsFuture;

  @override
  void initState() {
    super.initState();
    spellsFuture = loadSpells();
  }

  Future<List<Spell>> loadSpells() async {
    await SyncService.loadSpellsIfNeeded();
    return SpellLocalDatabase.getSpells();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zaklęcia'),
      ),
      body: FutureBuilder<List<Spell>>(
        future: spellsFuture,
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
          final spells = snapshot.data ?? [];
          return ListView.builder(
            itemCount: spells.length,
            itemBuilder: (context, index) {
              final spell = spells[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.auto_fix_high,
                    color: Colors.amber,
                  ),
                  title: Text(
                    spell.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(spell.description),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
