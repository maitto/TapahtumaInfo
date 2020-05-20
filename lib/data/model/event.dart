import 'package:meta/meta.dart';

class Event {
  final String name;
  final String time;
  final String place;
  final String tags;

  Event({
    @required this.name,
    @required this.time,
    @required this.place,
    @required this.tags
  });
}