import 'package:flutter/foundation.dart';
import 'package:movie_app/domain/api_client/api_client.dart';
import '../models/genre.dart';

class GenreProvider extends ChangeNotifier {
  final _apiClient = ApiClient();

  List<Genre> _genres = [];
  List<Genre> get genres => List.unmodifiable(_genres);

  Future<void> loadGenres() async {
    var genres = await _apiClient.getGenres();
    _genres.addAll(genres);
    notifyListeners();
  }
}
