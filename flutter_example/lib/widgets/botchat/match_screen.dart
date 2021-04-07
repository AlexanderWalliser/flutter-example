import 'package:flutter/material.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/models/match_model.dart';
import 'package:flutter_example/widgets/botchat/chat_screen.dart';
import 'package:flutter_example/widgets/profile/profile.dart';
import 'package:provider/provider.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Matches"),
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
      body: Consumer<MatchModel>(builder: (context, model, child) {
        return ListView.separated(
          itemCount: model.persons.length,
          padding: EdgeInsets.all(8),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(model.persons[index].id),
              onDismissed: (direction) {
                setState(() {
                  model.remove(model.persons[index]);
                });
              },
              child: _listEntry(model.persons[index]),
            );
          },
        );
      }),
    );
  }

  _listEntry(Person person) {
    return SizedBox(
      child: Card(
        child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        person: person,
                      ))),
          contentPadding: EdgeInsets.only(left: 7),
          leading: AspectRatio(
            aspectRatio: 487 / 451,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: NetworkImage(person.imageUrl),
                  )),
            ),
          ),
          title: Text(person.name),
          subtitle: Text(
            person.age.toString() + " years old",
            textScaleFactor: 0.8,
          ),
        ),
      ),
    );
  }
}
