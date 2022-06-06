import 'dart:convert';

class Cast {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      adult: map['adult'] ?? false,
      gender: map['gender']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      knownForDepartment: map['known_for_department'] ?? '',
      name: map['name'] ?? '',
      originalName: map['original_name'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      profilePath: map['profile_path'] ?? '',
      castId: map['cast_id']?.toInt() ?? 0,
      character: map['character'] ?? '',
      creditId: map['credit_id'] ?? '',
      order: map['order']?.toInt() ?? 0,
    );
  }

  factory Cast.fromJson(String source) => Cast.fromMap(json.decode(source));
}
