import 'package:flutter/widgets.dart';
import 'package:flutter_example/entities/account.dart';
import 'package:flutter_example/entities/gender.dart';

class AccountModel extends ChangeNotifier{
  Account _account;

  Account get account => _account.copy();

  AccountModel(): _account = new Account("https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Google_account_icon.svg/1200px-Google_account_icon.svg.png",
      "Max Mustermann",Gender.male,25);

  set account(Account account){
    this._account.name = account.name;
    this._account.picturePath = account.picturePath;
    this._account.age = account.age;
    this._account.preferedGender = account.preferedGender;
  }

  set imagePath(String imagePath){
    this._account.picturePath = imagePath;
    notifyListeners();
  }
}