import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class LeaderboardEntry {
  final String name;
  final String profilePictureUrl;
  final int score;

  LeaderboardEntry(this.name, this.profilePictureUrl, this.score);
}

class LeaderboardEntryWidget extends StatelessWidget {
  final LeaderboardEntry entry;
  final int? place;

  LeaderboardEntryWidget(this.entry, this.place);

  Color determineColor(int? place, int accent) {
    if (place == null) {
      return Colors.white;
    } else
    if (place == 1) {
      return Colors.deepPurple[300]!;
    } else if (place == 2) {
      return Colors.deepPurple[200]!;
    } else if (place == 3) {
      return Colors.deepPurple[100]!;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: determineColor(place, 100),
      child: ListTile(
        title: Row(
          children: [
            Text(
              place != null ? place.toString() : "--",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(width: 8.0),
            CircleAvatar(
              backgroundImage: NetworkImage(entry.profilePictureUrl),
            ),
            SizedBox(width: 8.0),
            Text(
              entry.name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              entry.score.toString(),
              // style: TextStyle(color: Colors.grey[600]),
            )
          ],
        ),
        // trailing: T,
      ),
    );
  }
}

class Leaderboards extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<Leaderboards> createState() => _LeaderboardsState();
}

List<LeaderboardEntry> generateUsers(int numberOfUsers) {
  List<LeaderboardEntry> users = [];

  for (int i = 1; i <= numberOfUsers; i++) {
    String name = 'User$i';
    String profilePictureUrl =
        'https://xsgames.co/randomusers/assets/avatars/male/$i.jpg';
    int score = 100 * (5 - i);

    users.add(LeaderboardEntry(name, profilePictureUrl, score));
  }

  return users;
}

class _LeaderboardsState extends State<Leaderboards> {
  List<LeaderboardEntry> users = generateUsers(15);
  LeaderboardEntry currentUser = LeaderboardEntry('Current User',
      'https://xsgames.co/randomusers/assets/avatars/male/6.jpg', 80);

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
                itemCount: users.length,
                itemBuilder: (_, index) {
                  final entry = users[index];
                  return LeaderboardEntryWidget(entry, index + 1);
                }),
          ),
        ),
        Container(
          // decoration: BoxDecoration(
          //   color: Colors.grey[100],
          //   borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(10),
          //     topLeft: Radius.circular(10),
          //   ),
          // )
          alignment: Alignment.center,
          child: LeaderboardEntryWidget(currentUser, null),
        ),
      ],
    );
  }
}
