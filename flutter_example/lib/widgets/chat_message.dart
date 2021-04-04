import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({@required this.message,@required  this.isMyMessage});

  final Message message;
  final bool isMyMessage;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
            backgroundImage: NetworkImage(message.imageUrl),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.message.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(this.message.text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.message.name, style: Theme.of(context).textTheme.subtitle1),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(this.message.text),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
            backgroundImage: NetworkImage(message.imageUrl),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            this.isMyMessage ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
