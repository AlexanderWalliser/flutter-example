import 'package:flutter/material.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/models/explore_model.dart';
import 'package:flutter_example/models/live_chat_model.dart';
import 'package:flutter_example/models/match_model.dart';
import 'package:flutter_example/widgets/app.dart';
import 'package:provider/provider.dart';

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
    var exploreModel = ExploreModel();
    var liveChatModel = LiveChatModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MatchModel()),
      ChangeNotifierProvider(create: (_) => AccountModel()),
      ChangeNotifierProvider(create: (_) => exploreModel),
      ChangeNotifierProvider(create: (_) => liveChatModel),
    ], child: App());
  }
}
