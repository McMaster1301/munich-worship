import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LeaderboardEntry {
  final String name;
  final String profilePictureUrl;
  final int score;

  LeaderboardEntry(this.name, this.profilePictureUrl, this.score);
}

class LeaderboardEntryWidget extends StatelessWidget {
  final LeaderboardEntry entry;
  final int place;

  LeaderboardEntryWidget(this.entry, this.place);

  @override
  Widget build(BuildContext context) {
    Color? placeColor;
    if (place == 1) {
      placeColor = Colors.amber[200];
    } else if (place == 2) {
      placeColor = Colors.grey[200];
    } else if (place == 3) {
      placeColor = Colors.brown[200];
    } else {
      placeColor = Colors.white;
    }

    return Card(
      color: placeColor,
      child: ListTile(
        leading: Text(
          "$place.",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(entry.profilePictureUrl),
            ),
            SizedBox(width: 8.0),
            Text(
              entry.name,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: Text(
          entry.score.toString(),
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}

class Leaderboards extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<Leaderboards> createState() => _LeaderboardsState();
}

class _LeaderboardsState extends State<Leaderboards> {
  @override
  void initState() {
    super.initState();
    //This is the place to fetch sth for api since it is only done once (not in build where it is rebuilt every time)
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (_, index) {
                  final entry = LeaderboardEntry('name', 'https://picsum.photos/250?image=9', 100);
                  return LeaderboardEntryWidget(entry, index + 1);
                }),
          ),
        ),
      ],
    );
  }
}
