import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_example/entities/account.dart';
import 'package:flutter_example/entities/gender.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:provider/provider.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreen createState() => _ProfileUpdateScreen();
}

class _ProfileUpdateScreen extends State<ProfileUpdateScreen> {
  Account account;
  bool changed = false;
  String genderValue = "";

  @override
  Widget build(BuildContext context) {
    if(account == null){
      account =  context.read<AccountModel>().account;
    }
    if(genderValue == ""){
      genderValue =
      account.preferedGender == Gender.male ? "Männlich" : "Weiblich";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil bearbeiten"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            goBack();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done
            ),
            onPressed: (){
              save();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: context.read<AccountModel>().picture,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Name"),
              initialValue: account.name,
              autocorrect: false,
              onChanged: (String newvalue) {
                changed = true;
                account.name = newvalue;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Alter",
              ),
              initialValue: account.age.toString(),
              keyboardType: TextInputType.number,
              autocorrect: false,
              onChanged: (String newvalue) {
                changed = true;
                account.age = int.parse(newvalue);
              },
            ),

            Stack(
              children: [
                Positioned(
                  top: 10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Bevorzugtes Geschlecht",
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12
                      ),
                    ),
                  ),
                ),
                dropdown()
              ],
            )
          ],
        ),
      ));
  }

  goBack() async {
    bool exit = true;
    if (changed == true) {
      Widget cancelButton = TextButton(
          onPressed: () {
            exit = false;
            Navigator.pop(context);
          },
          child: Text("Nein"));
      Widget continueButton = TextButton(
          onPressed: () {
            exit = true;
            Navigator.pop(context);
          },
          child: Text("Ja"));

      AlertDialog alert = AlertDialog(
        title: Text("Zurück ohne zu speichern?"),
        content: Text(
            "Möchtest du wirklich zurück ohne die Änderungen zu speichern?"),
        actions: [cancelButton, continueButton],
      );
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (exit == true) {
      Navigator.pop(context);
    }
  }

  save() {
    if (this.changed == true) {
      context.read<AccountModel>().account = account;
    }
    Navigator.pop(context);
  }

  Widget dropdown() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: DropdownButton<String>(
        isExpanded: true,
        value: genderValue,
        elevation: 16,
        underline: Container(
          width: 10000,
          height: 1,
          color: Colors.grey,
        ),
        onChanged: (String newValue) {
          setState(() {
            genderValue = newValue;
            account.preferedGender = genderValue == "Männlich" ? Gender.male: Gender.female;
            changed = true;
          });
        },
        items: <String>["Männlich", "Weiblich"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}
