import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:my_app/data/model/event.dart';
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
    final response = await http.get('http://api.hel.fi/linkedevents/v1/event/');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = jsonDecode(response.body);

      var list = data['data'] as List;
      List<Event> events = list.map((i) => Event.fromJson(i)).toList();

      

      return events;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load events');
    }
  }
}
