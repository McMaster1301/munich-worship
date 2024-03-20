import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        decoration: BoxDecoration(border: Border.all()),
        child: const Text(overflow: TextOverflow.ellipsis, 'Events'));
  }
}
