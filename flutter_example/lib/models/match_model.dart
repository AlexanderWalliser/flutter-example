import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/file_storage.dart';

class MatchModel extends ChangeNotifier {
  List<Person> _persons = [];

  UnmodifiableListView<Person> get persons => UnmodifiableListView(_persons);

  FileStorage<Person> _fileStorage;

  MatchModel(this._fileStorage) {
    _fileStorage.load((json) => Person.fromJson(json)).then((value) {
      _persons = value;
      notifyListeners();
    }).catchError((_) => _persons = []);
  }

  void _save() {
    _fileStorage.save(_persons);
  }

  void add(Person person) {
    _persons.add(person);
    _save();
    notifyListeners();
  }

  void remove(Person person) {
    _persons.remove(person);
    _save();
    notifyListeners();
  }

  void addMessage(String id, Message message) {
    _persons.firstWhere((p) => p.id == id, orElse: null)?.messages?.add(message);
    _save();
    notifyListeners();
  }
  List<Message> getMessagesOfPerson(String id){
    return UnmodifiableListView(_persons.firstWhere((p) => p.id == id, orElse: null)?.messages ?? []);
  }
}
