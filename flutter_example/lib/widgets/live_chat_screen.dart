import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/models/live_chat_model.dart';
import 'package:flutter_example/widgets/chat_message.dart';
import 'package:flutter_example/widgets/profile.dart';
import 'package:provider/provider.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({Key key}) : super(key: key);

  @override
  _LiveChatScreenState createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Live Chat"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.account_circle
            ),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> ProfileScreen())
              );
            },
          )
        ],
      ),
      body: Column(children: <Widget>[
        Flexible(child: Consumer<LiveChatModel>(
          builder: (context, model, child) {
            var messages = model.messages.reversed.toList();
            _textController.clear();
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => ChatMessage(
                message: messages[index],
                isMyMessage: messages[index].author ==
                    context.read<AccountModel>().account.id,
                ownPicture: context.read<AccountModel>().picture,
              ),
              itemCount: messages.length,
            );
          },
        )),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _textInput(),
        ),
      ]),
    );
  }

  Widget _textInput() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
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
    context.read<LiveChatModel>().create(Message(
        name: context.read<AccountModel>().account.name,
        text: text,
        imageUrl: context.read<AccountModel>().account.picturePath,
        author: context.read<AccountModel>().account.id));
  }
}
