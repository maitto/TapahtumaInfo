import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_app/data/model/event.dart';

import './bloc.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  @override
  EventState get initialState => EventInitial();

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is GetEvents) {
      yield EventsLoading();
      final events = await _fetchEventsFromFakeApi();
      yield EventsLoaded(events);
    }
  }

  Future<List<Event>> _fetchEventsFromFakeApi() {
    return Future.delayed(
      Duration(seconds: 2),
      () {
        return [Event(name: "name", place: "place", tags: "tags", time: "time")];
      }
    );
  }
}
