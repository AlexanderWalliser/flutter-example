import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/models/account_model.dart';
import 'package:flutter_example/models/match_model.dart';
import 'package:flutter_example/services/dialog_flow_service.dart';
import 'package:flutter_example/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final Person person;

  const ChatScreen({Key key, @required this.person}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = new TextEditingController();
  MatchModel _matchModel;

  @override
  void initState() {
    _matchModel = context.read<MatchModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(this.widget.person.name),
      ),
      body: Column(children: <Widget>[
        Flexible(
          child: Selector<MatchModel, List<Message>>(
            selector: (_, model) => model.getMessagesOfPerson(widget.person.id),
            builder: (context, value, child) {
              var messages = value.reversed.toList();
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => ChatMessage(
                  message: messages[index],
                  isMyMessage: messages[index].author ==
                      context.read<AccountModel>().account.id,
                ),
                itemCount: messages.length,
              );
            },
          ),
        ),
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
    setState(() {
      _matchModel.addMessage(
          widget.person.id,
          Message(
              name: context.read<AccountModel>().account.name,
              text: text,
              imageUrl: context.read<AccountModel>().account.picturePath,
              author: context.read<AccountModel>().account.id));
    });
    DialogFlowService.getBotResponse(text).then((value) => setState(() {
          _textController.clear();
          _matchModel.addMessage(
              widget.person.id,
              Message(
                name: widget.person.name,
                text: value,
                imageUrl: widget.person.imageUrl,
                author: widget.person.id,
              ));
        }));
  }
}
