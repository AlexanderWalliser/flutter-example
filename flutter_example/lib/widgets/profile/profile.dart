import 'package:flutter/material.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/models/theme_model.dart';
import 'package:flutter_example/widgets/profile/profile_update.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AccountModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Profil"),
              centerTitle: true,
            ),
            body: Container(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: (size.height * 0.4)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: model.picture,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        model.account.name + ", " + model.account.age.toString(),
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                context.read<ThemeModel>().toggleTheme();
                              });
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
                                    Icons.remove_red_eye,
                                    size: 35,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "THEME",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
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
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ProfileUpdateScreen()));
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
              ),
            ));
      },
    );
  }


  Future updatePictureOfUser() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        context.read<AccountModel>().imagePath = imagePath;
      }
    } catch (e) {}
  }
}
