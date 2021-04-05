import 'package:flutter/material.dart';
import 'package:flutter_example/entities/person.dart';
import 'package:flutter_example/models/explore_model.dart';
import 'package:flutter_example/models/match_model.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  CardController controller = CardController();
  List<Person> persons = [];
  ExploreModel model;
  @override
  void initState() {
    model = context.read<ExploreModel>();
    persons = model.persons.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        body: Container(
          height: size.height,
          child: TinderSwapCard(
            totalNum: persons.length,
            maxWidth: MediaQuery
                .of(context)
                .size
                .width,
            maxHeight: MediaQuery
                .of(context)
                .size
                .height * 0.92,
            minWidth: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            minHeight: MediaQuery
                .of(context)
                .size
                .height * 0.9,
            cardBuilder: (context, index) =>
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(persons[index]
                                    .imageUrl),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(0.25),
                                Colors.black.withOpacity(0),
                              ],
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: size.width * 0.72,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                persons[index].name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                persons[index].age
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    shape: BoxShape.circle),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Recently Active",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            cardController: controller,
            swipeCompleteCallback: (CardSwipeOrientation orientation,
                int index) {
              var person = persons[index];

              setState(() {
                persons.removeAt(0);
                if (persons.length <= 2) {
                  var modelPersons = model.persons.toList();
                  modelPersons.removeRange(0, 3);
                  persons.addAll(modelPersons);
                }
              });
              if (orientation == CardSwipeOrientation.RIGHT) {
                context.read<MatchModel>().add(person);
              }
              model.removePerson(person);
            },
          ),
        )
    );
  }
}

