import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_example/entities/person.dart';

class MatchModel extends ChangeNotifier{
  List<Person> _persons;

  UnmodifiableListView<Person> get persons => UnmodifiableListView(_persons);


  MatchModel(): _persons = [];

  void add(Person person){
    _persons.add(person);
    notifyListeners();
  }

  void remove(Person person){
    _persons.remove(person);
    notifyListeners();
  }
}