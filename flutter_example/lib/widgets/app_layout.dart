import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/explore_screen.dart';
import 'package:flutter_example/widgets/live_chat_screen.dart';
import 'package:flutter_example/widgets/match_screen.dart';

class AppLayout extends StatefulWidget {
  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.switch_account), label: "Matches"),
          BottomNavigationBarItem(icon: Icon(Icons.swipe), label: "Find"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
      body: getPage(_currentIndex),
    );
  }

  Widget getPage(int index){
    switch(index){
      case 0: return MatchScreen();
      case 1: return ExploreScreen();
      case 2: return  LiveChatScreen();
    }
    return null;
  }
}
