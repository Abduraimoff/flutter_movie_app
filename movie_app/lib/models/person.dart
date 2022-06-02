import 'dart:convert';

class Person {
  final int id;
  final String genre;
  final String name;
  final String profilePath;
  final String knowForDepartment;
  final double popularity;

  Person({
    required this.id,
    required this.genre,
    required this.name,
    required this.profilePath,
    required this.knowForDepartment,
    required this.popularity,
  });
//profile_path know_for_department
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'genre': genre,
      'name': name,
      'profile_path': profilePath,
      'know_for_department': knowForDepartment,
      'popularity': popularity,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id']?.toInt() ?? 0,
      genre: map['genre'] ?? '',
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      knowForDepartment: map['know_for_department'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}
