class User {
  final String? name;
  final int? age;

  User({
    required this.name,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      age: data['age'],
    );
  }
}
