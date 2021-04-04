import 'package:flutter/widgets.dart';
import 'package:flutter_example/entities/account.dart';

import 'package:flutter_example/entities/gender.dart';
import 'package:flutter_example/file_storage.dart';

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
    _account = new Account(
        "https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png",
        "Max Mustermann",
        Gender.male,
        25);
    _save();
    notifyListeners();
  }

  set account(Account account) {
    this._account.name = account.name;
    this._account.picturePath = account.picturePath;
    this._account.age = account.age;
    this._account.preferedGender = account.preferedGender;
    _save();
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
