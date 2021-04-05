import 'package:flutter/material.dart';
import 'package:flutter_example/file_storage.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/models/explore_model.dart';
import 'package:flutter_example/models/live_chat_model.dart';
import 'package:flutter_example/models/match_model.dart';
import 'package:flutter_example/models/theme_model.dart';
import 'package:flutter_example/widgets/app.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class ProviderApp extends StatefulWidget {
  @override
  _ProviderApp createState() => _ProviderApp();
}

class _ProviderApp extends State<ProviderApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var exploreModel =
        ExploreModel(FileStorage("explore", getApplicationDocumentsDirectory));
    var liveChatModel = LiveChatModel();
    var accountModel =
        AccountModel(FileStorage("account", getApplicationDocumentsDirectory));
    var matchModel =
        MatchModel(FileStorage("match", getApplicationDocumentsDirectory));
    var themeModel =
        ThemeModel(FileStorage("theme",getApplicationDocumentsDirectory));
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => matchModel),
      ChangeNotifierProvider(create: (_) => accountModel),
      ChangeNotifierProvider(create: (_) => exploreModel),
      ChangeNotifierProvider(create: (_) => liveChatModel),
      ChangeNotifierProvider(create: (_) => themeModel),
    ], child: App());
  }
}
