import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/services/person_service.dart';

class ExploreModel extends ChangeNotifier {
  List<Person> _persons;

  UnmodifiableListView<Person> get persons => UnmodifiableListView(_persons);

  ExploreModel() : _persons = [] {
    _load();
  }

  _load() {
    Future.forEach(Iterable<int>.generate(10), (_) => _generatePerson())
        .then((value) => notifyListeners());
  }

  _generatePerson() async {
    _persons.add(await PersonService.getPerson("female"));
  }

  removePerson(Person person) async {
    if(_persons.remove(person)) {
      await _generatePerson();
      notifyListeners();
    }
  }
}
