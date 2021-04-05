import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/file_storage.dart';
import 'package:flutter_example/services/person_service.dart';

class ExploreModel extends ChangeNotifier {
  List<Person> _persons = [];

  UnmodifiableListView<Person> get persons => UnmodifiableListView(_persons);

  FileStorage<Person> _fileStorage;

  ExploreModel(this._fileStorage) {
    _fileStorage.load((json) => Person.fromJson(json)).then((value) {
      if (value != null) {
        _persons = value;
        notifyListeners();
      } else {
        _load();
      }
    }).catchError((_) => _load());
  }

  void _save() {
    _fileStorage.save(_persons);
  }

  _load() {
    Future.forEach(Iterable<int>.generate(10), (_) => _generatePerson())
        .then((value) {
      _save();
      notifyListeners();
    });
  }

  _generatePerson() async {
    _persons.add(await PersonService.getPerson("female"));
  }

  removePerson(Person person) async {
    if (_persons.remove(person)) {
      await _generatePerson();
      _save();
      notifyListeners();
    }
  }
}
