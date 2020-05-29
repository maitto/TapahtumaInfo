import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:my_app/data/model/event.dart';
import 'package:my_app/data/model/place.dart';
import 'package:my_app/data/model/tag.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class EventBloc extends Bloc<EventEvent, EventState> {
  @override
  EventState get initialState => EventInitial();

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is GetEvents) {
      yield EventsLoading();
      final events = await _fetchEvents();
      yield EventsLoaded(events);
    }
  }

  Future<List<Event>> _fetchEvents() async {
    final response = await http.get('http://api.hel.fi/linkedevents/v1/event/?start=today&end=2020-12-31&sort=-date_published&event_status=EventScheduled');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);

      var list = data['data'] as List;
      List<Event> events = list.map((i) => Event.fromJson(i)).toList();

      for (Event event in events) {
        final place = await _fetchPlaceFor(event);
        final tags = await _fetchTagsFor(event);
        event.place = place;
        event.tags = tags;
      }

      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load events');
    }
  }

  Future<String> _fetchPlaceFor(Event event) async {
    final response = await http.get(event.place);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);

      return Place.fromJson(data).name.toString();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load place');
    }
  }

  Future<List<String>> _fetchTagsFor(Event event) async {
    List<String> tags = [];
    for (String tag in event.tags) {
      final response = await http.get(tag);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final data = jsonDecode(response.body);

        tags.add(Tag.fromJson(data).name.toString());
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load place');
      }
    }
    return tags;
  }
}
