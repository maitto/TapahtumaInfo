import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


class Tag {
  final String name;

  Tag({
    @required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name']['fi']);
  }
}