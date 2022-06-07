// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/models/now_playing_movies.dart';
import 'package:movie_app/models/person.dart';
import 'package:movie_app/models/popular_movies.dart';

import '../../models/cast.dart';
import '../../models/upcoming_movies.dart';

class ApiClient {
  static const _host = 'https://api.themoviedb.org/3';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500/';
  static const _apiKey = 'YOUR_API_KEY';

  static String imageUrl(String path) => _imageUrl + path;

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validateToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validateToken);

    return sessionId;
  }

  Future<String> _makeToken() async {
    print('makeToken');
    final url = Uri.parse(
        'https://api.themoviedb.org/3/authentication/token/new?api_key=$_apiKey');

    final response = await http.get(url);

    final json = await jsonDecode(response.body);
    final token = json['request_token'] as String;

    return token;
  }

  Future<String> _validateUser(
      {required String username,
      required String password,
      required String requestToken}) async {
    print('validateUser');
    final url = Uri.parse(
        '$_host/authentication/token/validate_with_login?api_key=$_apiKey');

    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken
    };

    final response = await http.post(url, body: parameters);
    final json = await jsonDecode(response.body);
    final token = json['request_token'] as String;

    return token;
  }

  Future<String> _makeSession({required String requestToken}) async {
    print('makeSession');
    final url = Uri.parse(
      '$_host/authentication/session/new?api_key=$_apiKey',
    );

    final parameters = <String, dynamic>{'request_token': requestToken};

    final response = await http.post(url, body: parameters);
    final json = await jsonDecode(response.body);
    final sessionId = json['session_id'] as String;

    return sessionId;
  }

  Future<NowPlayingMovies> getNowPlayingMovie(int page) async {
    print('NowPlayingMovie');
    try {
      final url = Uri.parse(
          '$_host/movie/now_playing?api_key=$_apiKey&language=en-US&page=$page');

      final response = await http.get(url);
      var movies = NowPlayingMovies.fromJson(response.body);

      return movies;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }

  Future<PopularMovies> getPopularMovie(int page) async {
    print('getMovieByGenre');
    try {
      final url = Uri.parse(
          '$_host/movie/popular?api_key=$_apiKey&language=en-US&page=$page');
      final response = await http.get(url);
      var movies = PopularMovies.fromJson(response.body);

      return movies;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }

  Future<UpcomingMovies> getUpcomingMovies(int page) async {
    try {
      final url = Uri.parse(
          '$_host/movie/upcoming?api_key=$_apiKey&language=en-US&page=$page');
      final response = await http.get(url);
      var movies = UpcomingMovies.fromJson(response.body);

      return movies;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }

  Future<List<Genre>> getGenres() async {
    try {
      final url =
          Uri.parse('$_host/genre/movie/list?api_key=$_apiKey&language=en-US');

      final response = await http.get(url);
      final body = response.body;
      final json = jsonDecode(body);
      final genre = json['genres'] as List;
      List<Genre> genreList = genre.map((g) => Genre.fromMap(g)).toList();

      return genreList;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }

  Future<List<Person>> getTrendingPerson() async {
    try {
      final url = Uri.parse('$_host/trending/person/week?api_key=$_apiKey');

      final response = await http.get(url);
      final body = response.body;
      final json = jsonDecode(body);
      final person = json['results'] as List;
      List<Person> personList = person.map((p) => Person.fromMap(p)).toList();

      return personList;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }

  Future<MovieDetail> getMovieDetail(var movieId) async {
    print('getMovieDetail');
    try {
      final url =
          Uri.parse('$_host/movie/$movieId?api_key=$_apiKey&language=en-US');
      final response = await http.get(url);
      var movieDetail = MovieDetail.fromJson(response.body);
      movieDetail.trailerId = await getYoutubeId(movieId);
      movieDetail.castList = await getCastList(movieId);
      return movieDetail;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }

  Future<String> getYoutubeId(var id) async {
    try {
      final url = Uri.parse('$_host/movie/$id/videos?api_key=$_apiKey');
      final response = await http.get(url);
      final body = response.body;
      final json = jsonDecode(body);
      final youtubeId = json['results'][0]['key'];

      return youtubeId;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }

  Future<List<Cast>> getCastList(var id) async {
    try {
      final url = Uri.parse('$_host/movie/$id/credits?api_key=$_apiKey');
      final response = await http.get(url);
      final body = response.body;
      final json = jsonDecode(body);
      final list = json['cast'] as List;

      List<Cast> castList = list.map((c) => Cast.fromMap(c)).toList();

      return castList;
    } catch (e) {
      throw Exception('Exception occured: $e ');
    }
  }
}
