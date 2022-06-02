import 'package:flutter/foundation.dart';
import 'package:movie_app/models/person.dart';

import '../domain/api_client/api_client.dart';

class PersonProvider extends ChangeNotifier {
  final _apiClient = ApiClient();

  List<Person> _people = [];
  List<Person> get people => List.unmodifiable(_people);

  Future<void> loadPeople() async {
    var people = await _apiClient.getTrendingPerson();
    _people.addAll(people);
    notifyListeners();
  }
}
