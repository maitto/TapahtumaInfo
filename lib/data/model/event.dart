import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


class Event {
  final String name;
  final String time;
  String place;
  List<String> tags;
  String image;

  Event({
    @required this.name,
    @required this.time,
    @required this.place,
    @required this.tags,
    @required this.image
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final keywordsList = json['keywords'] as List;
    List<String> keywords = [];
    for(dynamic i in keywordsList) {
      keywords.add(i['@id']);
    }

    final imagesList = json['images'] as List; 

    return Event(
      name: json['name']['fi'] ?? json['name']['en'] ?? json['name']['sv'] ?? "",
      time: json['start_time'] ?? "",
      place: json['location']['@id'] ?? "",
      tags: keywords,
      image: imagesList.first['url']);
  }

  String getTags() {
    String tagString = "";

    for(String tag in tags) {
      tagString = tagString + "#" + tag + " ";
    }

    return tagString;
  }

  String getTime() {
    final local = DateTime.parse(time).toLocal();
    final timeString = local.day.toString() + "." + local.month.toString() + "." + local.year.toString();
    return timeString;
  }
}