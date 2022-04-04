class Character {
  final String? name;
  final int? age;

  Character({
    required this.name,
    required this.age,
  });

  factory Character.fromJson(Map<String, dynamic> data) {
    return Character(
      name: data['name'],
      age: data['age'],
    );
  }
}
