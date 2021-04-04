import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';
import 'package:flutter_example/services/live_chat_service.dart';
import 'package:flutter_example/services/sse_subscriber.dart';

class LiveChatModel extends ChangeNotifier {
  List<Message> _messages;

  List<Message> get messages {
    return _messages.toList();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  LiveChatModel() : _messages = [] {
    _getData();
  }

  void _getData() {
    load();
    print("Connect to Stream");
    var subscription = SseSubscriber("http://10.0.2.2:8080/chat/stream",
        (json) => Message.fromJson(json)).stream.listen((message) {
          _messages.add(message);
          notifyListeners();
    });
    subscription.onError((_) {
      subscription.cancel();
      Future.delayed(Duration(seconds: 10), () => _getData());
    });
  }

  Future load() async {
    if (!_isLoading) {
      _isLoading = true;
      return LiveChatService.getLiveMessages().then((loaded) {
        _messages.clear();
        _messages.addAll(loaded);
        notifyListeners();
        _isLoading = false;
      }).catchError((err) {
        _isLoading = false;
      });
    }
  }

  Future<bool> create(Message message) async {
    return LiveChatService.create(message);
  }
}
