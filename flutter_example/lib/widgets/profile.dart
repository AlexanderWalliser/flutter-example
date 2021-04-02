import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example/entities/account.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/widgets/profile_update.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  Account account;

  @override
  Widget build(BuildContext context) {
    account = Provider.of<AccountModel>(context).getAccount();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
        backgroundColor: ColorScheme.light().background,
        body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.only(
                left: 30, right: 30, bottom: (size.height * 0.4)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: getPictureOfAccount(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  getUserInfo(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.settings,
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "SETTINGS",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () {
                          this.updatePictureOfUser();
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Icon(
                                Icons.camera_alt,
                                size: 45,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "UPDATE PICTURE",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> ProfileUpdateScreen())
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 35,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "EDIT INFO",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  ImageProvider getPictureOfAccount() {
    if (account.picturePath.contains("assets/ProfilePlaceHolder.jfif")) {
      return AssetImage("assets/ProfilePlaceHolder.jfif");
    } else {
      return FileImage(new File(account.picturePath));
    }
  }

  String getUserInfo() {
    return account.name + ", " + account.age.toString();
  }

  Future updatePictureOfUser() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        var accountModel = Provider.of<AccountModel>(context, listen: false);
        accountModel.setImagePath(imagePath);
        setState(() {
          this.account = accountModel.getAccount();
        });
      }
    } catch (e) {}
  }
}
