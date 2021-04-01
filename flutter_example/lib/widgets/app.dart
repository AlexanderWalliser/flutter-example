import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/models/match_model.dart';
import 'package:flutter_example/services/image_service.dart';
import 'package:flutter_example/widgets/app_layout.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    Timer(
        Duration(milliseconds: 1500),
        () async => context
            .read<MatchModel>()
            .add(Person("Test", await ImageService.getImage(), 20, true)));

    // Timer.periodic(
    //     Duration(milliseconds: 1500),
    //     (_) async => context
    //         .read<MatchModel>()
    //         .add(Person("Test", await ImageService.getImage(), 20, true)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppLayout(),
    );
  }
}
