import 'package:flutter/material.dart';
import 'package:flutter_example/entities/message.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.message, this.myImage, this.otherImage});

  final Message message;
  final ImageProvider myImage;
  final ImageProvider otherImage;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
            backgroundImage: otherImage,
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
            backgroundImage: myImage,
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
            this.message.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
