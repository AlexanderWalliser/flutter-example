import 'package:flutter/material.dart';
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
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MatchModel()),
    ], child: App());
  }
}
