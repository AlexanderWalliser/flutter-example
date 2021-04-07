import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_example/entities/gender.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/services/person_service.dart';
import 'package:flutter_example/storage/file_storage.dart';

class ExploreModel extends ChangeNotifier {
  AccountModel _accountModel;
  List<Person> _persons = [];
  Gender _gender;

  UnmodifiableListView<Person> get persons => UnmodifiableListView(_persons);

  FileStorage<Person> _fileStorage;

  ExploreModel(this._fileStorage, this._accountModel) {
    _fileStorage.load((json) => Person.fromJson(json)).then((value) {
      if (value != null) {
        _persons = value;
        _gender = _persons[0].gender;
        notifyListeners();
      } else {
        _gender = _accountModel.account.preferedGender;
        _load();
      }
    }).catchError((_) => _load());
    _accountModel.addListener(() {
      if(_gender != null){
        _updateGender();
      }
    });
  }

  _updateGender(){
    if(_gender != _accountModel.account.preferedGender){
      _gender = _accountModel.account.preferedGender;
      _reset();
    }
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
    _persons.add(await PersonService.getPerson(_accountModel.account));
  }

  removePerson(Person person) async {
    if (_persons.remove(person)) {
      await _generatePerson();
      _save();
      notifyListeners();
    }
  }
  _reset(){
    this._persons = [];
    _load();
  }
}
