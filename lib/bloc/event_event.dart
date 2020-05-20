import 'package:meta/meta.dart';

@immutable
abstract class EventEvent {}

class GetEvents extends EventEvent {
  GetEvents();
}