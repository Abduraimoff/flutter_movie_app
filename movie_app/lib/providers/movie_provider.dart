import 'package:flutter/foundation.dart';
import 'package:movie_app/models/movie.dart';

import '../domain/api_client/api_client.dart';

class MovieProvider extends ChangeNotifier {
  final _apiClient = ApiClient();

  final List<Movie> _movies = [];
  List<Movie> get movies => List.unmodifiable(_movies);

  final List<Movie> _popularMovies = [];
  List<Movie> get popularMovies => List.unmodifiable(_popularMovies);

  final List<Movie> _upcomingMovies = [];
  List<Movie> get upcomingMovies => List.unmodifiable(_upcomingMovies);

  Future<void> loadMovies() async {
    final movies = await _apiClient.getNowPlayingMovie(1);
    _movies.addAll(movies.movies);
    notifyListeners();
  }

  Future<void> loadPopularMovies(int page) async {
    final movies = await _apiClient.getPopularMovie(page);
    _popularMovies.addAll(movies.movies);
    notifyListeners();
  }

  Future<void> loadUpcomingMovies(int page) async {
    final movies = await _apiClient.getUpcomingMovies(page);
    _upcomingMovies.addAll(movies.movies);
    notifyListeners();
  }
}
