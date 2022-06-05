import 'dart:convert';

class MovieDetail {
  final int id;
  final String title;
  final String backdropPath;
  final String budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runtime;
  final String voteAverage;
  final String voteCount;

  String? trailerId;

  MovieDetail({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.budget,
    required this.homePage,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
    this.trailerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backdropPath,
      'budget': budget,
      'home_page': homePage,
      'original_title': originalTitle,
      'overview': overview,
      'release_date': releaseDate,
      'runtime': runtime,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'trailerId': trailerId,
    };
  }

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      budget: map['budget'].toString(),
      homePage: map['home_page'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      runtime: map['runtime'].toString(),
      voteAverage: map['vote_average'].toString(),
      voteCount: map['vote_count'].toString(),
      trailerId: map['trailerId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetail.fromJson(String source) =>
      MovieDetail.fromMap(json.decode(source));
}
