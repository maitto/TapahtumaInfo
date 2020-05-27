import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


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

  factory Event.fromJson(Map<String, dynamic> json) {
    var name = json['name'];
    return Event(
      name: name['fi'],
      time: json['start_time'],
      place: "asdd",
      tags: "adddd");
  }
}