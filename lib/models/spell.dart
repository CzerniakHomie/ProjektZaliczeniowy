class Spell {
  final String id;
  final String name;
  final String description;

  Spell({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Spell.fromMap(Map map) {
    return Spell(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Nieznane',
      description: map['description'] ?? 'Brak opisu',
    );
  }
}
