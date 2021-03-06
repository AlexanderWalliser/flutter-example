import 'package:flutter/material.dart';
import 'package:flutter_example/entities/account.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/models/explore_model.dart';
import 'package:flutter_example/models/live_chat_model.dart';
import 'package:flutter_example/models/match_model.dart';
import 'package:flutter_example/models/theme_model.dart';
import 'package:flutter_example/storage/file_storage.dart';
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
    var accountModel =
        AccountModel(FileStorage<Account>("account", getApplicationDocumentsDirectory));
    var exploreModel = ExploreModel(
        FileStorage<Person>("explore", getApplicationDocumentsDirectory), accountModel);
    var liveChatModel = LiveChatModel();
    var matchModel =
        MatchModel(FileStorage<Person>("match", getApplicationDocumentsDirectory));


    var themeModel =
        ThemeModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => matchModel),
      ChangeNotifierProvider(create: (_) => accountModel),
      ChangeNotifierProvider(create: (_) => exploreModel),
      ChangeNotifierProvider(create: (_) => liveChatModel),
      ChangeNotifierProvider(create: (_) => themeModel),
    ], child: App());
  }
}
