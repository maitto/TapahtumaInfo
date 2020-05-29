import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


class Place {
  final String name;

  Place({
    @required this.name,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name']['fi']);
  }
}