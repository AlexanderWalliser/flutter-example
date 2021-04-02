import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/services/dialog_flow_service.dart';
import 'package:flutter_example/widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {
  final Person person;

  const ChatScreen({Key key, this.person}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = <Message>[];
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.widget.person.name),
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) =>
                  ChatMessage(
                      message: _messages[index],
                      myImage: NetworkImage(widget.person.imageUrl),
                      otherImage: NetworkImage(widget.person.imageUrl)),
              itemCount: _messages.length,
            )),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme
              .of(context)
              .cardColor),
          child: _textInput(),
        ),
      ]),
    );
  }

  Widget _textInput() {
    return IconTheme(
      data: IconThemeData(color: Theme
          .of(context)
          .accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitMessage,
                decoration:
                InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _submitMessage(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void _submitMessage(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, Message("I", text, true));
    });
    DialogFlowService.getBotResponse(text).then((value) =>
        setState(() {
          _textController.clear();
          _messages.insert(0, Message(widget.person.name, value, false));
        }));
  }
}
