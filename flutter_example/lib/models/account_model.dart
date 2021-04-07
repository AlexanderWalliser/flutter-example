import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_example/entities/account.dart';

import 'package:flutter_example/entities/gender.dart';
import 'package:flutter_example/storage/file_storage.dart';

class AccountModel extends ChangeNotifier {
  Account _account;
  FileStorage<Account> _fileStorage;

  Account get account => _account?.copy();

  AccountModel(this._fileStorage) {
    _fileStorage.load((json) => Account.fromJson(json)).then((value) {
      if (value?.first != null) {
        _account = value.first;
        notifyListeners();
      } else {
        _newAccount();
      }
    }).catchError((_) => _newAccount());
  }

  void _newAccount() {
    _account = new Account("", "Max Mustermann", Gender.male, 25);
    _save();
    notifyListeners();
  }

  ImageProvider get picture {
    if (_account.picturePath == null && _account.picturePath == "") {
      return AssetImage("assets/ProfilePlaceholder.jfif");
    } else {
      return FileImage(new File(_account.picturePath));
    }
  }

  set account(Account account) {
    this._account.name = account.name;
    this._account.picturePath = account.picturePath;
    this._account.age = account.age;
    this._account.preferedGender = account.preferedGender;
    _save();
    notifyListeners();
  }

  set imagePath(String imagePath) {
    this._account.picturePath = imagePath;
    _save();
    notifyListeners();
  }

  void _save() {
    _fileStorage.save([_account]);
  }
}
