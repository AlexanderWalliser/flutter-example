
import 'package:flutter/material.dart';
import 'package:flutter_example/models/names_model.dart';
import 'package:flutter_example/models/theme_model.dart';
import 'package:flutter_example/widgets/app_layout.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    NameModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppLayout(),
      theme: context.watch<ThemeModel>().getTheme(),
    );
  }
}
