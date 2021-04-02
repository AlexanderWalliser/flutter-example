import 'package:flutter/widgets.dart';
import 'package:flutter_example/entities/account.dart';
import 'package:flutter_example/entities/gender.dart';

class AccountModel extends ChangeNotifier{
  Account _account;

  Account getAccount(){
    return _account.copy();
  }


  AccountModel(): _account = new Account("assets/ProfilePlaceHolder.jfif",
      "Max Mustermann",Gender.male,25);

  void setAccount(Account account){
    this._account.set(account);
  }

  void setImagePath(String imagePath) {
    this._account.picturePath = imagePath;
  }
}