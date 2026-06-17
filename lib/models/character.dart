class Character {
  final String id;
  final String name;
  final String house;
  final String species;
  final String actor;
  final bool alive;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.house,
    required this.species,
    required this.actor,
    required this.alive,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'house': house,
      'species': species,
      'actor': actor,
      'alive': alive,
      'image': image,
    };
  }

  factory Character.fromMap(Map map) {
    return Character(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Nieznany',
      house: map['house'] ?? 'Brak domu',
      species: map['species'] ?? 'Nieznany',
      actor: map['actor'] ?? 'Nieznany',
      alive: map['alive'] ?? false,
      image: map['image'] ?? '',
    );
  }
}
