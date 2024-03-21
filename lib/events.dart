import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

var events = [1, 2, 3];

var users = [
  'https://xsgames.co/randomusers/assets/avatars/male/78.jpg',
];

final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

class Events extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  void initState() {
    super.initState();
    //This is the place to fetch sth for api since it is only done once (not in build where it is rebuilt every time)
  }

  Widget buildListElement(context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.075, 0, 0, 0),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: Text('Join', style: TextStyle(color: Colors.red)),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.width * 0.075, 0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(users[0]),
                    radius: 50,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width * 0.85,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.8,
                center: Text("80.0%"),
                barRadius: const Radius.circular(16),
                progressColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (_, index) {
                  final event = events[index];
                  return buildListElement(context);
                }),
          ),
        ),
      ],
    );
  }
}
