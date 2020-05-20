import 'package:meta/meta.dart';
import 'package:my_app/data/model/event.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventsLoading extends EventState {}

class EventsLoaded extends EventState {
  final List<Event> events;

  EventsLoaded(this.events);
}