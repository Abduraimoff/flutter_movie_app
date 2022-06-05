import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/api_client/api_client.dart';
import 'package:movie_app/models/movie_detail.dart';

class MovieDetailProvider extends ChangeNotifier {
  final _apiClient = ApiClient();

  final String movieId;
  MovieDetail? _movieDetail;
  MovieDetail? get movieDetail => _movieDetail;

  MovieDetailProvider(
    this.movieId,
  );

  Future<void> loadMovieDetail(String movieId) async {
    final detail = await _apiClient.getMovieDetail(movieId);
    _movieDetail = detail;
    notifyListeners();
  }
}
